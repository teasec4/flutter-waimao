import 'package:flutter/material.dart';

class TodoItemCard extends StatelessWidget {
  final String id;
  final String text;
  final bool isDone;
  final int? draggableIndex;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoItemCard({
    super.key,
    required this.id,
    required this.text,
    required this.isDone,
    this.draggableIndex,
    required this.onToggle,
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
          // Drag handle — отдельно
          if (draggableIndex != null)
            ReorderableDragStartListener(
              index: draggableIndex!,
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(Icons.drag_indicator,
                    color: theme.colorScheme.onSurfaceVariant),
              ),
            ),
          Checkbox(
            value: isDone,
            onChanged: (_) => onToggle(),
          ),
          Expanded(
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
          IconButton(
            icon: Icon(Icons.delete_outline, size: 18,
                color: theme.colorScheme.error),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
