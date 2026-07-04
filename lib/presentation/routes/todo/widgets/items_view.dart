import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/domain/entities/todo_item.dart';
import 'package:paste_tool/presentation/providers/todo_provider.dart';
import 'package:paste_tool/presentation/routes/todo/widgets/todo_item_card.dart';

/// Tasks of the selected list.
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
        title: const Text('New task'),
        content: TextField(
          controller: _textCtrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Task text'),
          onSubmitted: (_) => _submitItem(ctx),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => _submitItem(ctx),
            child: const Text('Add'),
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

  void _showEditItemDialog(TodoItem item) {
    _textCtrl.text = item.text;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit task'),
        content: TextField(
          controller: _textCtrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Task text'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final text = _textCtrl.text.trim();
              if (text.isEmpty) return;
              Navigator.pop(ctx);
              context.read<TodoProvider>().editItem(item.id, text);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(TodoItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete task?'),
        content: Text('«${item.text}»'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<TodoProvider>().deleteItem(item.id);
            },
            child: const Text('Delete'),
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

    return Stack(
      children: [
        Column(
          children: [
            _buildHeader(provider, list.name),
            if (provider.items.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.task_alt, size: 48, color: Colors.grey[400]),
                      const SizedBox(height: 12),
                      const Text(
                        'No tasks',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 4, bottom: 80),
                  itemCount: allOrdered.length,
                  itemBuilder: (context, index) {
                    final item = allOrdered[index];
                    return TodoItemCard(
                      key: ValueKey(item.id),
                      id: item.id,
                      text: item.text,
                      isDone: item.isDone,
                      onToggle: () => provider.toggleDone(item.id),
                      onEdit: () => _showEditItemDialog(item),
                      onDelete: () => _confirmDelete(item),
                    );
                  },
                ),
              ),
          ],
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            onPressed: _showAddItemDialog,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(TodoProvider provider, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 8, 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back to lists',
            onPressed: () => provider.backToLists(),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.checklist_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
