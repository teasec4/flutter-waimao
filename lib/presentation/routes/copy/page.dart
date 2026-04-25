import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
              provider.deleteCategory(id);
              Navigator.pop(ctx);
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
              provider.deletePhrase(id);
              Navigator.pop(ctx);
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
    if (provider.activeCategory != null || provider.showFavorites) {
      return _buildPhrasesView(provider);
    }
    return _buildCategoriesView(provider);
  }

  Widget _buildCategoriesView(PhraseProvider provider) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        final columns = isWide ? (constraints.maxWidth > 900 ? 3 : 2) : 1;

        return Stack(
          children: [
            Column(
              children: [
                // Панель действий: избранное
                if (provider.phrases.any((p) => p.isFavorite) ||
                    provider.showFavorites)
                  Container(
                    width: double.infinity,
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withValues(alpha: 0.3),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              provider.showFavorites
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () => provider.toggleFavoritesView(),
                            tooltip: 'Избранное',
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Избранное',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: provider.showFavorites
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: provider.categories.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.folder_open,
                                  size: 64, color: Colors.grey),
                              SizedBox(height: 16),
                              Text('Нет папок',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey)),
                              SizedBox(height: 8),
                              Text('Нажмите + чтобы создать',
                                  style:
                                      TextStyle(color: Colors.grey)),
                            ],
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.only(
                              top: 8, left: 8, right: 8, bottom: 80),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: columns,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: isWide ? 2.2 : 4.5,
                          ),
                          itemCount: provider.categories.length,
                          itemBuilder: (context, index) {
                            final cat = provider.categories[index];
                            return CategoryCard(
                              id: cat.id,
                              name: cat.name,
                              isWide: isWide,
                              onTap: () => provider.selectCategory(cat),
                              onRename: () => _showAddCategoryDialog(
                                id: cat.id,
                                initialName: cat.name,
                              ),
                              onDelete: () => _confirmDeleteCategory(
                                  provider, cat.id, cat.name),
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
                onPressed: () => _showAddCategoryDialog(),
                child: const Icon(Icons.create_new_folder),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPhrasesView(PhraseProvider provider) {
    final isFavorites = provider.showFavorites;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        final columns = isWide ? 2 : 1;

        return Stack(
          children: [
            Column(
              children: [
                // Верхняя панель: назад + заголовок + избранное
                Container(
                  width: double.infinity,
                  color: Theme.of(context)
                      .colorScheme
                      .inversePrimary
                      .withValues(alpha: 0.3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
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
                                  : Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                isFavorites
                                    ? 'Избранное'
                                    : provider.activeCategory?.name ?? '',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            if (!isFavorites)
                              IconButton(
                                icon: const Icon(Icons.edit, size: 20),
                                tooltip: 'Переименовать',
                                onPressed: () =>
                                    _showAddCategoryDialog(
                                  id: provider.activeCategory?.id,
                                  initialName:
                                      provider.activeCategory?.name,
                                ),
                              ),
                          ],
                        ),
                        // Поиск
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 8),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Поиск по фразам...',
                              prefixIcon: const Icon(Icons.search,
                                  size: 20),
                              suffixIcon: _searchController
                                      .text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(
                                          Icons.clear, size: 18),
                                      onPressed: () {
                                        _searchController.clear();
                                        provider.setSearchQuery('');
                                      },
                                    )
                                  : null,
                              isDense: true,
                              contentPadding:
                                  const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .outline),
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
                          ? Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    isFavorites
                                        ? Icons.favorite_border
                                        : Icons.content_paste,
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
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey),
                                  ),
                                  if (_searchController
                                      .text.isNotEmpty)
                                    TextButton(
                                      onPressed: () {
                                        _searchController.clear();
                                        provider.setSearchQuery('');
                                      },
                                      child:
                                          const Text('Очистить поиск'),
                                    ),
                                ],
                              ),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.only(
                                  top: 4,
                                  left: 8,
                                  right: 8,
                                  bottom: 80),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: columns,
                                mainAxisSpacing: 6,
                                crossAxisSpacing: 8,
                                childAspectRatio: isWide ? 3.0 : 5.0,
                              ),
                              itemCount: provider.phrases.length,
                              itemBuilder: (context, index) {
                                final phrase =
                                    provider.phrases[index];
                                return PhraseCard(
                                  id: phrase.id,
                                  text: phrase.text,
                                  isFavorite: phrase.isFavorite,
                                  onCopy: () =>
                                      _copyToClipboard(phrase.text),
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
}
