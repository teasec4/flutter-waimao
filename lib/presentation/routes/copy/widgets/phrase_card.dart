import 'package:flutter/material.dart';
import 'package:paste_tool/presentation/routes/copy/widgets/mini_icon_button.dart';

/// Карточка одной фразы с действиями: копировать / избранное / редактировать / удалить.
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
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onCopy,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  text,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MiniIconButton(
                    icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                    tooltip: isFavorite ? 'Убрать из избранного' : 'В избранное',
                    onPressed: onToggleFavorite,
                  ),
                  MiniIconButton(
                    icon: Icons.copy,
                    color: Colors.teal,
                    tooltip: 'Копировать',
                    onPressed: onCopy,
                  ),
                  MiniIconButton(
                    icon: Icons.edit,
                    color: Colors.blue,
                    tooltip: 'Редактировать',
                    onPressed: onEdit,
                  ),
                  MiniIconButton(
                    icon: Icons.delete,
                    color: Colors.red,
                    tooltip: 'Удалить',
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
