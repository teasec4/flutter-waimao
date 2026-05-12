import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/domain/entities/todo_item.dart';
import 'package:paste_tool/domain/entities/todo_list.dart';
import 'package:paste_tool/presentation/providers/todo_provider.dart';
import 'package:paste_tool/presentation/routes/todo/widgets/todo_item_card.dart';
import 'package:paste_tool/presentation/routes/todo/widgets/todo_list_card.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _nameController = TextEditingController();
  final _itemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoProvider>().loadLists();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _itemController.dispose();
    super.dispose();
  }

  void _showAddListDialog() {
    _nameController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Новый список'),
        content: TextField(
          controller: _nameController,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Название списка'),
          onSubmitted: (_) => _submitList(context),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          FilledButton(onPressed: () => _submitList(context), child: const Text('Создать')),
        ],
      ),
    );
  }

  void _submitList(BuildContext dialogContext) {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    Navigator.pop(dialogContext);
    context.read<TodoProvider>().addList(name);
  }

  void _showRenameDialog(String id, String currentName) {
    _nameController.text = currentName;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Переименовать'),
        content: TextField(
          controller: _nameController,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Новое название'),
          onSubmitted: (_) => _submitRename(context, id),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          FilledButton(onPressed: () => _submitRename(context, id), child: const Text('Сохранить')),
        ],
      ),
    );
  }

  void _submitRename(BuildContext dialogContext, String id) {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    Navigator.pop(dialogContext);
    context.read<TodoProvider>().renameList(id, name);
  }

  void _showAddItemDialog() {
    _itemController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Новая задача'),
        content: TextField(
          controller: _itemController,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Текст задачи'),
          onSubmitted: (_) => _submitItem(context),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          FilledButton(onPressed: () => _submitItem(context), child: const Text('Добавить')),
        ],
      ),
    );
  }

  void _submitItem(BuildContext dialogContext) {
    final text = _itemController.text.trim();
    if (text.isEmpty) return;
    Navigator.pop(dialogContext);
    context.read<TodoProvider>().addItem(text);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TodoProvider>();
    if (provider.activeList != null) {
      return _buildItemsView(provider);
    }
    return _buildListsView(provider);
  }

  Widget _buildListsView(TodoProvider provider) {
    return Scaffold(
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : provider.lists.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.checklist_rounded, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      const Text('Нет списков', style: TextStyle(fontSize: 18, color: Colors.grey)),
                      const SizedBox(height: 8),
                      const Text('Нажмите + чтобы создать', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              : ReorderableListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 80),
                  buildDefaultDragHandles: false,
                  itemCount: provider.lists.length,
                  onReorder: (oldIndex, newIndex) {
                    final updated = List<TodoList>.from(provider.lists);
                    final item = updated.removeAt(oldIndex);
                    updated.insert(newIndex, item);
                    provider.reorderLists(updated);
                  },
                  proxyDecorator: (child, index, animation) => Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(12),
                    child: child,
                  ),
                  itemBuilder: (context, index) {
                    final list = provider.lists[index];
                    return TodoListCard(
                      key: ValueKey(list.id),
                      id: list.id,
                      name: list.name,
                      draggableIndex: index,
                      onTap: () => provider.selectList(list),
                      onRename: () => _showRenameDialog(list.id, list.name),
                      onDelete: () => _confirmDeleteList(provider, list),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddListDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildItemsView(TodoProvider provider) {
    final list = provider.activeList!;
    final doneItems = provider.items.where((i) => i.isDone).toList();
    final pendingItems = provider.items.where((i) => !i.isDone).toList();
    final allOrdered = [...pendingItems, ...doneItems];

    return Scaffold(
      appBar: AppBar(
        title: Text(list.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => provider.backToLists(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            tooltip: 'Переименовать',
            onPressed: () => _showRenameDialog(list.id, list.name),
          ),
        ],
      ),
      body: provider.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.task_alt, size: 48, color: Colors.grey[400]),
                  const SizedBox(height: 12),
                  const Text('Нет задач', style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            )
          : ReorderableListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              buildDefaultDragHandles: false,
              itemCount: allOrdered.length,
              onReorder: (oldIndex, newIndex) {
                final updated = List<TodoItem>.from(allOrdered);
                final item = updated.removeAt(oldIndex);
                updated.insert(newIndex, item);
                provider.reorderItems(updated);
              },
              proxyDecorator: (child, index, animation) => Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                child: child,
              ),
              itemBuilder: (context, index) {
                final item = allOrdered[index];
                return TodoItemCard(
                  key: ValueKey(item.id),
                  id: item.id,
                  text: item.text,
                  isDone: item.isDone,
                  draggableIndex: index,
                  onToggle: () => provider.toggleDone(item.id),
                  onDelete: () => _confirmDeleteItem(provider, item),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmDeleteList(TodoProvider provider, TodoList list) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить список?'),
        content: Text('Все задачи в списке «${list.name}» будут удалены.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              provider.deleteList(list.id);
            },
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteItem(TodoProvider provider, TodoItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить задачу?'),
        content: Text('«${item.text}»'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              provider.deleteItem(item.id);
            },
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }
}
