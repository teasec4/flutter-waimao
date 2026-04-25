import 'package:flutter/material.dart';
import 'package:paste_tool/domain/entities/dictionary_entry.dart';

/// Карточка словарной записи: иероглиф, пиньинь, перевод(ы).
class EntryCard extends StatelessWidget {
  final DictionaryEntry entry;
  final ValueChanged<String> onCopy;
  final VoidCallback onToggleFavorite;

  const EntryCard({
    super.key,
    required this.entry,
    required this.onCopy,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => onCopy(entry.russian),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 4, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Иероглиф
                    Text(
                      entry.simplified,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (entry.pinyin.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        entry.pinyin,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                    const SizedBox(height: 6),
                    // Перевод(ы)
                    if (entry.meanings.isNotEmpty)
                      ...entry.meanings.map((m) => Padding(
                            padding: const EdgeInsets.only(bottom: 2, right: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (entry.meanings.length > 1)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: Text(
                                      '${m.orderNum + 1}.',
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(
                                        color:
                                            theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                Expanded(
                                  child: Text(
                                    m.text,
                                    style: theme.textTheme.bodyLarge,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ))
                    else
                      Text(
                        entry.russian,
                        style: theme.textTheme.bodyLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              // Кнопка копирования
              IconButton(
                icon: const Icon(Icons.copy, size: 20),
                tooltip: 'Скопировать перевод',
                onPressed: () => onCopy(entry.russian),
                visualDensity: VisualDensity.compact,
              ),
              // Кнопка избранного
              IconButton(
                icon: Icon(
                  entry.isFavorite ? Icons.star : Icons.star_border,
                  color: entry.isFavorite ? Colors.amber : null,
                ),
                tooltip: entry.isFavorite
                    ? 'Убрать из избранного'
                    : 'Добавить в избранное',
                onPressed: onToggleFavorite,
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
