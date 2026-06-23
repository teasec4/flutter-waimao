import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/domain/entities/phrase_category.dart';
import 'package:paste_tool/presentation/providers/phrase_provider.dart';
import 'package:paste_tool/presentation/routes/copy/widgets/phrase_card.dart';

/// Единый экран: чипсы категорий + список фраз.
class CopyPage extends StatefulWidget {
  const CopyPage({super.key});

  @override
  State<CopyPage> createState() => _CopyPageState();
}

class _CopyPageState extends State<CopyPage> {
  final _textCtrl = TextEditingController();
  final _searchCtrl = TextEditingController();
  final _chipScrollCtrl = ScrollController();

  @override
  void dispose() {
    _textCtrl.dispose();
    _searchCtrl.dispose();
    _chipScrollCtrl.dispose();
    super.dispose();
  }

  // --- Диалоги ---

  void _showAddCategoryDialog() {
    _textCtrl.clear();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Новая папка'),
        content: TextField(
          controller: _textCtrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Название папки'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () {
              if (_textCtrl.text.isNotEmpty) {
                context.read<PhraseProvider>().addCategory(_textCtrl.text);
                Navigator.pop(ctx);
              }
            },
            child: const Text('Создать'),
          ),
        ],
      ),
    );
  }

  void _showRenameCategoryDialog(PhraseCategory cat) {
    _textCtrl.text = cat.name;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Переименовать'),
        content: TextField(
          controller: _textCtrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Новое название'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () {
              if (_textCtrl.text.trim().isNotEmpty) {
                context.read<PhraseProvider>().renameCategory(
                  cat.id,
                  _textCtrl.text.trim(),
                );
                Navigator.pop(ctx);
              }
            },
            child: const Text('Переименовать'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteCategory(PhraseProvider p, PhraseCategory cat) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить папку?'),
        content: Text(
          'Папка «${cat.name}» и все фразы внутри неё будут удалены.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(ctx);
              p.deleteCategory(cat.id);
              _showSnack(
                Text('Папка «${cat.name}» удалена'),
                action: SnackBarAction(
                  label: 'Отменить',
                  onPressed: () => p.undoDeleteCategory(),
                ),
              );
            },
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }

  void _showPhraseDialog({String? id, String? initialText}) {
    final isEditing = id != null;
    _textCtrl.text = initialText ?? '';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isEditing ? 'Редактировать' : 'Новая фраза'),
        content: TextField(
          controller: _textCtrl,
          maxLines: 3,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Текст фразы'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () {
              if (_textCtrl.text.isNotEmpty) {
                final p = context.read<PhraseProvider>();
                if (isEditing) {
                  p.editPhrase(id, _textCtrl.text);
                } else {
                  p.addPhrase(_textCtrl.text);
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

  void _confirmDeletePhrase(PhraseProvider p, String id) {
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
              p.deletePhrase(id);
              _showSnack(
                const Text('Фраза удалена'),
                action: SnackBarAction(
                  label: 'Отменить',
                  onPressed: () => p.undoDeletePhrase(),
                ),
              );
            },
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    _showSnack(const Text('Скопировано!'));
  }

  void _pasteFromClipboard(PhraseProvider p) async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (!mounted) return;
    final text = data?.text;
    if (text != null && text.isNotEmpty) {
      await p.addPhrase(text);
      if (!mounted) return;
      _showSnack(
        Text(
          'Вставлено: "${text.length > 30 ? '${text.substring(0, 30)}…' : text}"',
        ),
      );
    } else {
      _showSnack(const Text('Буфер обмена пуст'));
    }
  }

  void _showSnack(Text content, {SnackBarAction? action}) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: content,
          duration: const Duration(milliseconds: 1000),
          behavior: SnackBarBehavior.floating,
          action: action,
        ),
      );
  }

  // --- Build ---

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PhraseProvider>();

    return Stack(
      children: [
        Column(
          children: [
            _buildChipBar(provider),
            _buildSearchBar(provider),
            Expanded(child: _buildPhraseList(provider)),
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

  // --- Чипсы категорий ---

  Widget _buildChipBar(PhraseProvider p) {
    final cats = p.categories;
    final activeId = p.activeCategory?.id;

    return SizedBox(
      height: 44,
      child: Row(
        children: [
          Expanded(
            child: ListView(
              controller: _chipScrollCtrl,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              children: cats
                  .map(
                    (cat) => Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: _chip(
                        label: cat.name,
                        selected: activeId == cat.id,
                        onTap: () => p.selectCategory(cat),
                        onLongPress: () => _showCategoryMenu(p, cat),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.content_paste, size: 18),
            tooltip: 'Вставить из буфера',
            onPressed: () => _pasteFromClipboard(p),
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 20),
            tooltip: 'Новая папка',
            onPressed: _showAddCategoryDialog,
          ),
        ],
      ),
    );
  }

  Widget _chip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    VoidCallback? onLongPress,
  }) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        padding: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }

  void _showCategoryMenu(PhraseProvider p, PhraseCategory cat) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Переименовать'),
              onTap: () {
                Navigator.pop(ctx);
                _showRenameCategoryDialog(cat);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Удалить'),
              onTap: () {
                Navigator.pop(ctx);
                _confirmDeleteCategory(p, cat);
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- Поиск ---

  Widget _buildSearchBar(PhraseProvider p) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
      child: TextField(
        controller: _searchCtrl,
        decoration: InputDecoration(
          hintText: 'Поиск...',
          prefixIcon: const Icon(Icons.search, size: 18),
          suffixIcon: _searchCtrl.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 16),
                  onPressed: () {
                    _searchCtrl.clear();
                    p.setSearchQuery('');
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
        onChanged: p.setSearchQuery,
      ),
    );
  }

  // --- Список фраз ---

  Widget _buildPhraseList(PhraseProvider p) {
    if (p.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (p.phrases.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _searchCtrl.text.isNotEmpty
                  ? Icons.search_off
                  : Icons.content_paste,
              size: 48,
              color: Colors.grey,
            ),
            const SizedBox(height: 12),
            Text(
              _searchCtrl.text.isNotEmpty
                  ? 'Ничего не найдено'
                  : 'В папке нет фраз',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 2, bottom: 80),
      itemCount: p.phrases.length,
      itemBuilder: (_, i) {
        final phrase = p.phrases[i];
        return PhraseCard(
          key: ValueKey(phrase.id),
          id: phrase.id,
          text: phrase.text,
          onCopy: () => _copyToClipboard(phrase.text),
          onEdit: () =>
              _showPhraseDialog(id: phrase.id, initialText: phrase.text),
          onDelete: () => _confirmDeletePhrase(p, phrase.id),
        );
      },
    );
  }
}
