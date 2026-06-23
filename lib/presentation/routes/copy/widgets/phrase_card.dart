import 'package:flutter/material.dart';

/// Компактная карточка фразы.
class PhraseCard extends StatelessWidget {
  final String id;
  final String text;
  final bool isCopied;
  final VoidCallback onCopy;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const PhraseCard({
    super.key,
    required this.id,
    required this.text,
    this.isCopied = false,
    required this.onCopy,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        child: InkWell(
          onTap: onCopy,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      color: isCopied
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                _ActionBtn(
                  icon: isCopied ? Icons.check : Icons.copy,
                  color: isCopied ? Colors.green : theme.colorScheme.primary,
                  onTap: onCopy,
                  tooltip: 'Копировать',
                ),
                const SizedBox(width: 2),
                _ActionBtn(
                  icon: Icons.edit,
                  color: Colors.blue,
                  onTap: onEdit,
                  tooltip: 'Редактировать',
                ),
                const SizedBox(width: 2),
                _ActionBtn(
                  icon: Icons.delete,
                  color: theme.colorScheme.error,
                  onTap: onDelete,
                  tooltip: 'Удалить',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final String? tooltip;

  const _ActionBtn({
    required this.icon,
    required this.color,
    required this.onTap,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: IconButton(
        icon: Icon(icon, size: 18),
        color: color,
        onPressed: onTap,
        padding: EdgeInsets.zero,
        splashRadius: 16,
        tooltip: tooltip,
      ),
    );
  }
}
