import 'package:flutter/material.dart';

/// Компактная карточка фразы.
class PhraseCard extends StatelessWidget {
  final String id;
  final String text;
  final VoidCallback onCopy;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PhraseCard({
    super.key,
    required this.id,
    required this.text,
    required this.onCopy,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: InkWell(
        onTap: onCopy,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(width: 6),
              _Btn(
                icon: Icons.copy,
                color: theme.colorScheme.primary,
                onTap: onCopy,
                tooltip: 'Копировать',
              ),
              const SizedBox(width: 2),
              _Btn(
                icon: Icons.edit,
                color: Colors.blue,
                onTap: onEdit,
                tooltip: 'Редактировать',
              ),
              const SizedBox(width: 2),
              _Btn(
                icon: Icons.delete,
                color: Colors.red,
                onTap: onDelete,
                tooltip: 'Удалить',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Btn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final String? tooltip;

  const _Btn({
    required this.icon,
    required this.color,
    required this.onTap,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: IconButton(
        icon: Icon(icon, size: 16),
        color: color,
        onPressed: onTap,
        padding: EdgeInsets.zero,
        splashRadius: 14,
        tooltip: tooltip,
      ),
    );
  }
}
