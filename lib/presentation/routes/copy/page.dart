import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/domain/entities/phrase.dart';
import 'package:paste_tool/domain/entities/phrase_category.dart';
import 'package:paste_tool/presentation/providers/phrase_provider.dart';
import 'package:paste_tool/presentation/routes/copy/widgets/category_card.dart';
import 'package:paste_tool/presentation/routes/copy/widgets/phrase_card.dart';

class CopyPage extends StatefulWidget {
  const CopyPage({super.key});

  @override
  State<CopyPage> createState() => _CopyPageState();
}

class _CopyPageState extends State<CopyPage> {
  final _contentController = TextEditingController();
  final _searchController = TextEditingController();
  bool _showFavorites = true;

  @override
  void dispose() {
    _contentController.dispose();
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
      provider.addPhrase(text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Вставлено: "${text.length > 30 ? '${text.substring(0, 30)}…' : text}"'),
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
    _contentController.text = initialText ?? '';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEditing ? 'Редактировать фразу' : 'Новая фраза'),
        content: TextField(
          controller: _contentController,
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
              if (_contentController.text.isNotEmpty) {
                final provider = context.read<PhraseProvider>();
                if (isEditing) {
                  provider.editPhrase(id, _contentController.text);
                } else {
                  provider.addPhrase(_contentController.text);
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

  void _showAddCategoryDialog({String? id, String? initialName}) {
    final isEditing = id != null;
    _contentController.text = initialName ?? '';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEditing ? 'Переименовать папку' : 'Новая папка'),
        content: TextField(
          controller: _contentController,
          decoration: const InputDecoration(
            labelText: 'Название папки',
            hintText: 'Например: Деловая переписка',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () {
              if (_contentController.text.isNotEmpty) {
                final provider = context.read<PhraseProvider>();
                if (isEditing) {
                  provider.renameCategory(id, _contentController.text);
                } else {
                  provider.addCategory(_contentController.text);
                }
                Navigator.pop(ctx);
              }
            },
            child: Text(isEditing ? 'Переименовать' : 'Создать'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteCategory(PhraseProvider provider, String id, String name) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить папку?'),
        content: Text('Папка «$name» и все фразы внутри неё будут удалены.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx);
              provider.deleteCategory(id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Папка «$name» удалена'),
                  duration: const Duration(seconds: 4),
                  action: SnackBarAction(
                    label: 'Отменить',
                    onPressed: () => provider.undoDeleteCategory(),
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Фраза удалена'),
                  duration: const Duration(seconds: 4),
                  action: SnackBarAction(
                    label: 'Отменить',
                    onPressed: () => provider.undoDeletePhrase(),
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
    if (provider.activeCategory != null) {
      return _buildPhrasesView(provider);
    }
    return _buildCategoriesView(provider);
  }

  Widget _buildCategoriesView(PhraseProvider provider) {
    // Фильтруем категории
    final allCategories = _showFavorites
        ? provider.categories
        : provider.categories
            .where((c) => !provider.isFavoritesById(c.id))
            .toList();
    final favorites = allCategories.where((c) => provider.isFavoritesById(c.id)).toList();
    final reordereable = allCategories.where((c) => !provider.isFavoritesById(c.id)).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            // Быстрые настройки
            _buildQuickSettingsPanel(),
            Expanded(
              child: Stack(
                children: [
                  allCategories.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_open,
                                  size: 64, color: Colors.grey),
                              const SizedBox(height: 16),
                              const Text('Нет папок',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey)),
                              const SizedBox(height: 8),
                              const Text(
                                  'Нажмите + чтобы создать',
                                  style: TextStyle(
                                      color: Colors.grey)),
                            ],
                          ),
                        )
                      : ListView(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 80),
                          children: [
                            // Избранное — статическая карточка
                            if (favorites.isNotEmpty)
                              CategoryCard(
                                key: ValueKey(favorites.first.id),
                                id: favorites.first.id,
                                name: favorites.first.name,
                                phraseCount:
                                    provider.phraseCounts[
                                            favorites.first.id] ??
                                        0,
                                onTap: () => provider
                                    .selectCategory(favorites.first),
                                onRename: () {},
                                onDelete: () {},
                                canDelete: false,
                              ),
                            if (favorites.isNotEmpty)
                              const Divider(height: 2, indent: 32),
                            // Остальные категории — перетаскиваемые
                            ReorderableListView.builder(
                              shrinkWrap: true,
                              physics:
                                  const NeverScrollableScrollPhysics(),
                              buildDefaultDragHandles: false,
                              itemCount: reordereable.length,
                              onReorder: (oldIndex, newIndex) {
                                final updated =
                                    List<PhraseCategory>.from(
                                        reordereable);
                                final item =
                                    updated.removeAt(oldIndex);
                                updated.insert(newIndex, item);
                                provider.reorderCategories(
                                    updated);
                              },
                              proxyDecorator:
                                  (child, index, animation) =>
                                      Material(
                                elevation: 4,
                                borderRadius:
                                    BorderRadius.circular(8),
                                child: child,
                              ),
                              itemBuilder: (context, index) {
                                final cat = reordereable[index];
                                return CategoryCard(
                                  key: ValueKey(cat.id),
                                  id: cat.id,
                                  name: cat.name,
                                  phraseCount:
                                      provider.phraseCounts[
                                              cat.id] ??
                                          0,
                                  showDragHandle: true,
                                  onTap: () => provider
                                      .selectCategory(cat),
                                  onRename: () =>
                                      _showAddCategoryDialog(
                                    id: cat.id,
                                    initialName: cat.name,
                                  ),
                                  onDelete: () =>
                                      _confirmDeleteCategory(
                                          provider,
                                          cat.id,
                                          cat.name),
                                  canDelete: provider
                                      .canDeleteCategory(cat.id),
                                );
                              },
                            ),
                          ],
                        ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: FloatingActionButton(
                      onPressed: () => _showAddCategoryDialog(),
                      child:
                          const Icon(Icons.create_new_folder),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildQuickSettingsPanel() {
    return Container(
      width: double.infinity,
      color: Theme.of(context)
          .colorScheme
          .surfaceContainerHighest
          .withValues(alpha: 0.5),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          children: [
            Icon(Icons.tune,
                size: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(width: 8),
            Text(
              'Показать избранное',
              style: TextStyle(
                fontSize: 13,
                color:
                    Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const Spacer(),
            Switch(
              value: _showFavorites,
              onChanged: (v) => setState(() => _showFavorites = v),
              materialTapTargetSize:
                  MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhrasesView(PhraseProvider provider) {
    final isFavorites = provider.isFavoritesCategory;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Column(
              children: [
                // Верхняя панель: назад + заголовок
                Container(
                  width: double.infinity,
                  
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 6),
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
                              isFavorites
                                  ? Icons.favorite
                                  : Icons.folder,
                              color: isFavorites
                                  ? Colors.red
                                  : Theme.of(context)
                                      .colorScheme
                                      .primary,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                isFavorites
                                    ? 'Избранное'
                                    : provider
                                            .activeCategory?.name ??
                                        '',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            if (!isFavorites)
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, size: 20),
                                tooltip: 'Переименовать',
                                onPressed: () =>
                                    _showAddCategoryDialog(
                                  id: provider.activeCategory?.id,
                                  initialName:
                                      provider.activeCategory?.name,
                                ),
                              ),
                            IconButton(
                              icon: const Icon(Icons.content_paste,
                                  size: 20),
                              tooltip: 'Вставить из буфера',
                              onPressed: () =>
                                  _pasteFromClipboard(provider),
                            ),
                          ],
                        ),
                        // Поиск
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 6, top: 8),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Поиск...',
                              prefixIcon: const Icon(Icons.search,
                                  size: 18),
                              suffixIcon: _searchController
                                      .text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(
                                          Icons.clear, size: 16),
                                      onPressed: () {
                                        _searchController.clear();
                                        provider.setSearchQuery('');
                                      },
                                    )
                                  : null,
                              isDense: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: provider.setSearchQuery,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Список фраз
                Expanded(
                  child: provider.loading
                      ? const Center(
                          child: CircularProgressIndicator())
                      : provider.phrases.isEmpty
                          ? _buildEmptyPhrases(isFavorites, provider)
                          : ReorderableListView.builder(
                              padding: const EdgeInsets.only(
                                  top: 2, bottom: 80),
                              buildDefaultDragHandles: false,
                              itemCount: provider.phrases.length,
                              onReorder: (oldIndex, newIndex) {
                                final updated =
                                    List<Phrase>.from(
                                        provider.phrases);
                                final item =
                                    updated.removeAt(oldIndex);
                                updated.insert(newIndex, item);
                                provider.reorderPhrases(updated);
                              },
                              proxyDecorator:
                                  (child, index, animation) =>
                                      Material(
                                elevation: 4,
                                borderRadius:
                                    BorderRadius.circular(8),
                                child: child,
                              ),
                              itemBuilder: (context, index) {
                                final phrase =
                                    provider.phrases[index];
                                return PhraseCard(
                                  key: ValueKey(phrase.id),
                                  id: phrase.id,
                                  text: phrase.text,
                                  isFavorite: phrase.isFavorite,
                                  showDragHandle: true,
                                  onCopy: () =>
                                      _copyToClipboard(
                                          phrase.text),
                                  onToggleFavorite: () =>
                                      provider.toggleFavorite(
                                    phrase.id,
                                    !phrase.isFavorite,
                                  ),
                                  onEdit: () =>
                                      _showPhraseDialog(
                                    id: phrase.id,
                                    initialText: phrase.text,
                                  ),
                                  onDelete: () =>
                                      _confirmDeletePhrase(
                                          provider, phrase.id),
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
      },
    );
  }

  Widget _buildEmptyPhrases(bool isFavorites, PhraseProvider provider) {
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
