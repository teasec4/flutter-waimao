import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/presentation/providers/dictionary_provider.dart';
import 'package:paste_tool/presentation/routes/dictionary/widgets/entry_card.dart';
import 'package:paste_tool/presentation/routes/dictionary/widgets/mode_chip.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _copy(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Скопировано: $text'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        _buildSearchBar(theme),
        _buildModeChips(),
        const Divider(height: 1),
        Expanded(child: _buildResults()),
      ],
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Китайский, пиньинь или перевод...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<DictionaryProvider>().search('');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          filled: true,
          fillColor: theme.colorScheme.surfaceContainerHighest,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onChanged: (v) => context.read<DictionaryProvider>().search(v),
      ),
    );
  }

  Widget _buildModeChips() {
    return Consumer<DictionaryProvider>(
      builder: (context, provider, _) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            ModeChip(
              label: 'Все',
              icon: Icons.menu_book,
              selected: !provider.showFavorites,
              onTap: () {
                if (provider.showFavorites) provider.toggleFavorites();
              },
            ),
            const SizedBox(width: 8),
            ModeChip(
              label: 'Избранное',
              icon: Icons.star,
              selected: provider.showFavorites,
              onTap: () {
                if (!provider.showFavorites) provider.toggleFavorites();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults() {
    return Consumer<DictionaryProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final entries = provider.filteredEntries;

        if (provider.isEmpty) {
          return _buildEmptyState(provider);
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 700;

            if (isWide) {
              return GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 2.8,
                ),
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return EntryCard(
                    entry: entry,
                    onCopy: (text) => _copy(text),
                    onToggleFavorite: () =>
                        context.read<DictionaryProvider>().toggleFavorite(entry.id),
                  );
                },
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return EntryCard(
                  entry: entry,
                  onCopy: (text) => _copy(text),
                  onToggleFavorite: () =>
                      context.read<DictionaryProvider>().toggleFavorite(entry.id),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState(DictionaryProvider provider) {
    final theme = Theme.of(context);
    final isFavoritesMode = provider.showFavorites;
    final hasQuery = provider.query.isNotEmpty;

    String icon;
    String title;
    String subtitle;

    if (isFavoritesMode) {
      icon = '⭐';
      title = 'Нет избранных слов';
      subtitle =
          'Нажимайте на звёздочку у слов, чтобы добавить их в избранное';
    } else if (hasQuery) {
      icon = '🔍';
      title = 'Ничего не найдено';
      subtitle = 'Попробуйте изменить запрос';
    } else {
      icon = '📖';
      title = 'Введите запрос для поиска';
      subtitle = 'Китайские иероглифы, пиньинь или русский перевод';
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(icon, style: const TextStyle(fontSize: 56)),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium
                  ?.copyWith(color: theme.colorScheme.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
