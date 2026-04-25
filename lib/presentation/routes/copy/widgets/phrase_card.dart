import 'package:flutter/material.dart';

/// Компактная карточка фразы без фона.
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

    return InkWell(
      onTap: onCopy,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13),
              ),
            ),
            const SizedBox(width: 4),
            _ActionChip(
              icon: isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
              onPressed: onToggleFavorite,
            ),
            const SizedBox(width: 2),
            _ActionChip(
              icon: Icons.copy,
              color: theme.colorScheme.primary,
              onPressed: onCopy,
            ),
            const SizedBox(width: 2),
            _ActionChip(
              icon: Icons.edit,
              color: Colors.blue,
              onPressed: onEdit,
            ),
            const SizedBox(width: 2),
            _ActionChip(
              icon: Icons.delete,
              color: Colors.red,
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _ActionChip({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: IconButton(
        icon: Icon(icon, size: 16),
        color: color,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        splashRadius: 14,
        tooltip: null,
      ),
    );
  }
}
