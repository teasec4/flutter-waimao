import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/domain/entities/todo_item.dart';
import 'package:paste_tool/presentation/providers/todo_provider.dart';
import 'package:paste_tool/presentation/routes/todo/widgets/todo_item_card.dart';

/// Экран с задачами выбранного списка.
class ItemsView extends StatefulWidget {
  const ItemsView({super.key});

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  final _textCtrl = TextEditingController();

  @override
  void dispose() {
    _textCtrl.dispose();
    super.dispose();
  }

  void _showAddItemDialog() {
    _textCtrl.clear();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Новая задача'),
        content: TextField(
          controller: _textCtrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Текст задачи'),
          onSubmitted: (_) => _submitItem(ctx),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () => _submitItem(ctx),
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  void _submitItem(BuildContext dialogContext) {
    final text = _textCtrl.text.trim();
    if (text.isEmpty) return;
    Navigator.pop(dialogContext);
    context.read<TodoProvider>().addItem(text);
  }

  void _confirmDelete(TodoItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить задачу?'),
        content: Text('«${item.text}»'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<TodoProvider>().deleteItem(item.id);
            },
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TodoProvider>();
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
      ),
      body: provider.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.task_alt, size: 48, color: Colors.grey[400]),
                  const SizedBox(height: 12),
                  const Text(
                    'Нет задач',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              itemCount: allOrdered.length,
              itemBuilder: (context, index) {
                final item = allOrdered[index];
                return TodoItemCard(
                  key: ValueKey(item.id),
                  id: item.id,
                  text: item.text,
                  isDone: item.isDone,
                  onToggle: () => provider.toggleDone(item.id),
                  onDelete: () => _confirmDelete(item),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
