import 'package:flutter/material.dart';

/// Увеличенная карточка фразы с кнопками действий.
class PhraseCard extends StatelessWidget {
  final String id;
  final String text;
  final bool isFavorite;
  final VoidCallback onCopy;
  final VoidCallback onToggleFavorite;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PhraseCard({
    super.key,
    required this.id,
    required this.text,
    this.isFavorite = false,
    required this.onCopy,
    required this.onToggleFavorite,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final cardBody = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(width: 8),
          _ActionChip(
            icon: isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Colors.grey,
            onPressed: onToggleFavorite,
            tooltip: isFavorite ? 'Убрать из избранного' : 'В избранное',
          ),
          const SizedBox(width: 4),
          _ActionChip(
            icon: Icons.copy,
            color: theme.colorScheme.primary,
            onPressed: onCopy,
            tooltip: 'Копировать',
          ),
          const SizedBox(width: 4),
          _ActionChip(
            icon: Icons.edit,
            color: Colors.blue,
            onPressed: onEdit,
            tooltip: 'Редактировать',
          ),
          const SizedBox(width: 4),
          _ActionChip(
            icon: Icons.delete,
            color: Colors.red,
            onPressed: onDelete,
            tooltip: 'Удалить',
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        onTap: onCopy,
        child: cardBody,
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;
  final String? tooltip;

  const _ActionChip({
    required this.icon,
    required this.color,
    required this.onPressed,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: IconButton(
        icon: Icon(icon, size: 20),
        color: color,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        splashRadius: 18,
        tooltip: tooltip,
      ),
    );
  }
}
