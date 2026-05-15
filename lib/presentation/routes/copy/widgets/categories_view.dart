import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/presentation/providers/phrase_provider.dart';
import 'package:paste_tool/presentation/routes/copy/widgets/category_card.dart';

/// Экран со списком категорий (папок) фраз.
class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final _nameController = TextEditingController();
  bool _showFavorites = true;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _showAddCategoryDialog({String? id, String? initialName}) {
    final isEditing = id != null;
    _nameController.text = initialName ?? '';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEditing ? 'Переименовать папку' : 'Новая папка'),
        content: TextField(
          controller: _nameController,
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
              if (_nameController.text.isNotEmpty) {
                final provider = context.read<PhraseProvider>();
                if (isEditing) {
                  provider.renameCategory(id, _nameController.text);
                } else {
                  provider.addCategory(_nameController.text);
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

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PhraseProvider>();

    final allCategories = _showFavorites
        ? provider.categories
        : provider.categories
              .where((c) => !provider.isFavoritesById(c.id))
              .toList();
    final favorites = allCategories
        .where((c) => provider.isFavoritesById(c.id))
        .toList();
    final regularCategories = allCategories
        .where((c) => !provider.isFavoritesById(c.id))
        .toList();

    return Column(
      children: [
        _buildQuickSettingsPanel(),
        Expanded(
          child: Stack(
            children: [
              allCategories.isEmpty
                  ? _buildEmptyState()
                  : ListView(
                      padding: const EdgeInsets.only(top: 8, bottom: 80),
                      children: [
                        if (favorites.isNotEmpty)
                          CategoryCard(
                            key: ValueKey(favorites.first.id),
                            id: favorites.first.id,
                            name: favorites.first.name,
                            phraseCount:
                                provider.phraseCounts[favorites.first.id] ?? 0,
                            onTap: () =>
                                provider.selectCategory(favorites.first),
                            onRename: () {},
                            onDelete: () {},
                            canDelete: false,
                          ),
                        if (favorites.isNotEmpty)
                          const Divider(height: 2, indent: 32),
                        ...regularCategories.map(
                          (cat) => CategoryCard(
                            key: ValueKey(cat.id),
                            id: cat.id,
                            name: cat.name,
                            phraseCount: provider.phraseCounts[cat.id] ?? 0,
                            onTap: () => provider.selectCategory(cat),
                            onRename: () => _showAddCategoryDialog(
                              id: cat.id,
                              initialName: cat.name,
                            ),
                            onDelete: () => _confirmDeleteCategory(
                              provider,
                              cat.id,
                              cat.name,
                            ),
                            canDelete: provider.canDeleteCategory(cat.id),
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
          ),
        ),
      ],
    );
  }

  Widget _buildQuickSettingsPanel() {
    return Container(
      width: double.infinity,
      color: Theme.of(
        context,
      ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          children: [
            Icon(
              Icons.tune,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Text(
              'Показать избранное',
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const Spacer(),
            Switch(
              value: _showFavorites,
              onChanged: (v) => setState(() => _showFavorites = v),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_open, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Нет папок',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            'Нажмите + чтобы создать',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
