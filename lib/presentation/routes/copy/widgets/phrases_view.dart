import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/presentation/providers/phrase_provider.dart';
import 'package:paste_tool/presentation/routes/copy/widgets/phrase_card.dart';

/// Экран со списком фраз в выбранной категории.
class PhrasesView extends StatefulWidget {
  const PhrasesView({super.key});

  @override
  State<PhrasesView> createState() => _PhrasesViewState();
}

class _PhrasesViewState extends State<PhrasesView> {
  final _textController = TextEditingController();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Скопировано!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _pasteFromClipboard(PhraseProvider provider) async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (!mounted) return;
    final text = data?.text;
    if (text != null && text.isNotEmpty) {
      await provider.addPhrase(text);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Вставлено: "${text.length > 30 ? '${text.substring(0, 30)}…' : text}"',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Буфер обмена пуст'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _showPhraseDialog({String? id, String? initialText}) {
    final isEditing = id != null;
    _textController.text = initialText ?? '';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEditing ? 'Редактировать фразу' : 'Новая фраза'),
        content: TextField(
          controller: _textController,
          decoration: const InputDecoration(
            labelText: 'Текст фразы',
            hintText: 'Введите текст',
          ),
          maxLines: 3,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                final provider = context.read<PhraseProvider>();
                if (isEditing) {
                  provider.editPhrase(id, _textController.text);
                } else {
                  provider.addPhrase(_textController.text);
                }
                Navigator.pop(ctx);
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _showRenameCategoryDialog(PhraseProvider provider) {
    final cat = provider.activeCategory;
    if (cat == null) return;
    final ctrl = TextEditingController(text: cat.name);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Переименовать папку'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(labelText: 'Название папки'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () {
              if (ctrl.text.trim().isNotEmpty) {
                provider.renameCategory(cat.id, ctrl.text.trim());
                Navigator.pop(ctx);
              }
            },
            child: const Text('Переименовать'),
          ),
        ],
      ),
    );
  }

  void _confirmDeletePhrase(PhraseProvider provider, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить фразу?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx);
              provider.deletePhrase(id);
              final provider2 = context.read<PhraseProvider>();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Фраза удалена'),
                  duration: const Duration(seconds: 4),
                  action: SnackBarAction(
                    label: 'Отменить',
                    onPressed: () => provider2.undoDeletePhrase(),
                  ),
                ),
              );
            },
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PhraseProvider>();
    final isFavorites = provider.isFavoritesCategory;

    return Stack(
      children: [
        Column(
          children: [
            _buildTopBar(provider, isFavorites),
            _buildSearchBar(provider),
            Expanded(
              child: provider.loading
                  ? const Center(child: CircularProgressIndicator())
                  : provider.phrases.isEmpty
                  ? _buildEmptyState(isFavorites, provider)
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 2, bottom: 80),
                      itemCount: provider.phrases.length,
                      itemBuilder: (context, index) {
                        final phrase = provider.phrases[index];
                        return PhraseCard(
                          key: ValueKey(phrase.id),
                          id: phrase.id,
                          text: phrase.text,
                          isFavorite: phrase.isFavorite,
                          onCopy: () => _copyToClipboard(phrase.text),
                          onToggleFavorite: () => provider.toggleFavorite(
                            phrase.id,
                            !phrase.isFavorite,
                          ),
                          onEdit: () => _showPhraseDialog(
                            id: phrase.id,
                            initialText: phrase.text,
                          ),
                          onDelete: () =>
                              _confirmDeletePhrase(provider, phrase.id),
                        );
                      },
                    ),
            ),
          ],
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            onPressed: () => _showPhraseDialog(),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar(PhraseProvider provider, bool isFavorites) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    provider.selectCategory(null);
                    _searchController.clear();
                  },
                  tooltip: 'Назад к папкам',
                ),
                const SizedBox(width: 8),
                Icon(
                  isFavorites ? Icons.favorite : Icons.folder,
                  color: isFavorites
                      ? Colors.red
                      : Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    isFavorites
                        ? 'Избранное'
                        : provider.activeCategory?.name ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (!isFavorites)
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    tooltip: 'Переименовать',
                    onPressed: () => _showRenameCategoryDialog(provider),
                  ),
                IconButton(
                  icon: const Icon(Icons.content_paste, size: 20),
                  tooltip: 'Вставить из буфера',
                  onPressed: () => _pasteFromClipboard(provider),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(PhraseProvider provider) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 6),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Поиск...',
          prefixIcon: const Icon(Icons.search, size: 18),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 16),
                  onPressed: () {
                    _searchController.clear();
                    provider.setSearchQuery('');
                  },
                )
              : null,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 10,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: provider.setSearchQuery,
      ),
    );
  }

  Widget _buildEmptyState(bool isFavorites, PhraseProvider provider) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isFavorites ? Icons.favorite_border : Icons.content_paste,
            size: 48,
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          Text(
            _searchController.text.isNotEmpty
                ? 'Ничего не найдено'
                : isFavorites
                ? 'Нет избранных фраз'
                : 'В папке нет фраз',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          if (_searchController.text.isNotEmpty)
            TextButton(
              onPressed: () {
                _searchController.clear();
                provider.setSearchQuery('');
              },
              child: const Text('Очистить поиск'),
            ),
        ],
      ),
    );
  }
}
