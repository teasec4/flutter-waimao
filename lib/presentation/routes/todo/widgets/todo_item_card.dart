import 'package:flutter/material.dart';

class TodoItemCard extends StatelessWidget {
  final String id;
  final String text;
  final bool isDone;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TodoItemCard({
    super.key,
    required this.id,
    required this.text,
    required this.isDone,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      color: isDone
          ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
          : null,
      child: Row(
        children: [
          Checkbox(value: isDone, onChanged: (_) => onToggle()),
          Expanded(
            child: InkWell(
              onTap: onEdit,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 15,
                    decoration: isDone ? TextDecoration.lineThrough : null,
                    color: isDone
                        ? theme.colorScheme.onSurfaceVariant
                        : theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.edit_outlined,
              size: 18,
              color: theme.colorScheme.primary,
            ),
            onPressed: onEdit,
            tooltip: 'Редактировать',
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              size: 18,
              color: theme.colorScheme.error,
            ),
            onPressed: onDelete,
            tooltip: 'Удалить',
          ),
        ],
      ),
    );
  }
}
