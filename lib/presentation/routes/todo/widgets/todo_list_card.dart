import 'package:flutter/material.dart';

class TodoListCard extends StatelessWidget {
  final String id;
  final String name;
  final VoidCallback onTap;
  final VoidCallback onRename;
  final VoidCallback onDelete;

  const TodoListCard({
    super.key,
    required this.id,
    required this.name,
    required this.onTap,
    required this.onRename,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Row(
        children: [
          // Card body — InkWell
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    Icon(Icons.checklist_rounded,
                        color: theme.colorScheme.primary, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(name,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                    PopupMenuButton<String>(
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'rename', child: Text('Rename')),
                        const PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                      onSelected: (value) {
                        if (value == 'rename') onRename();
                        if (value == 'delete') onDelete();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
