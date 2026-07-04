import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/domain/entities/todo_list.dart';
import 'package:paste_tool/presentation/providers/todo_provider.dart';
import 'package:paste_tool/presentation/routes/todo/widgets/todo_list_card.dart';

/// List of todo lists.
class ListsView extends StatefulWidget {
  const ListsView({super.key});

  @override
  State<ListsView> createState() => _ListsViewState();
}

class _ListsViewState extends State<ListsView> {
  final _nameCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  void _showAddListDialog() {
    _nameCtrl.clear();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New list'),
        content: TextField(
          controller: _nameCtrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'List name'),
          onSubmitted: (_) => _submitList(ctx),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => _submitList(ctx),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _submitList(BuildContext dialogContext) {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) return;
    Navigator.pop(dialogContext);
    context.read<TodoProvider>().addList(name);
  }

  void _showRenameDialog(String id, String currentName) {
    _nameCtrl.text = currentName;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Rename'),
        content: TextField(
          controller: _nameCtrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'New name'),
          onSubmitted: (_) => _submitRename(ctx, id),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => _submitRename(ctx, id),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _submitRename(BuildContext dialogContext, String id) {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) return;
    Navigator.pop(dialogContext);
    context.read<TodoProvider>().renameList(id, name);
  }

  void _confirmDelete(TodoList list) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete list?'),
        content: Text('All tasks in "${list.name}" will be deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<TodoProvider>().deleteList(list.id);
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

    if (provider.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: provider.lists.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.checklist_rounded,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No lists',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tap + to create',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              itemCount: provider.lists.length,
              itemBuilder: (context, index) {
                final list = provider.lists[index];
                return TodoListCard(
                  key: ValueKey(list.id),
                  id: list.id,
                  name: list.name,
                  onTap: () => provider.selectList(list),
                  onRename: () => _showRenameDialog(list.id, list.name),
                  onDelete: () => _confirmDelete(list),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddListDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
