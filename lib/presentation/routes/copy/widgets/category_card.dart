import 'package:flutter/material.dart';

/// Увеличенная карточка папки. Правый клик / долгое нажатие — контекстное меню.
class CategoryCard extends StatelessWidget {
  final String id;
  final String name;
  final bool isFirst;
  final int phraseCount;
  final VoidCallback onTap;
  final VoidCallback onRename;
  final VoidCallback onDelete;
  final bool canDelete;

  const CategoryCard({
    super.key,
    required this.id,
    required this.name,
    this.isFirst = false,
    this.phraseCount = 0,
    required this.onTap,
    required this.onRename,
    required this.onDelete,
    this.canDelete = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final cardBody = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Icon(
            id == 'favorites' ? Icons.favorite : Icons.folder,
            size: 22,
            color: id == 'favorites'
                ? Colors.red
                : theme.colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _formatCount(phraseCount),
              style: TextStyle(
                fontSize: 13,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: GestureDetector(
        onTap: onTap,
        onSecondaryTap: () => _showContextMenu(context),
        onLongPress: () => _showContextMenu(context),
        child: cardBody,
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  void _showContextMenu(BuildContext context) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 200, 200),
      items: [
        PopupMenuItem(
          value: 'rename',
          child: ListTile(
            leading: const Icon(Icons.edit, size: 22),
            title: const Text('Переименовать', style: TextStyle(fontSize: 16)),
            dense: true,
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
          ),
        ),
        if (canDelete)
          PopupMenuItem(
            value: 'delete',
            child: ListTile(
              leading: const Icon(Icons.delete, size: 22, color: Colors.red),
              title: const Text('Удалить',
                  style: TextStyle(fontSize: 16, color: Colors.red)),
              dense: true,
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
            ),
          ),
      ],
    ).then((value) {
      if (value == 'rename') onRename();
      if (value == 'delete') onDelete();
    });
  }
}
