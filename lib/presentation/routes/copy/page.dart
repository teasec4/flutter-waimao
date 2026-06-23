import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/domain/entities/phrase.dart';
import 'package:paste_tool/domain/entities/phrase_category.dart';
import 'package:paste_tool/presentation/providers/phrase_provider.dart';
import 'package:paste_tool/presentation/routes/copy/widgets/phrase_card.dart';
import 'package:paste_tool/presentation/widgets/snack_mixin.dart';

/// Единый экран: чипсы категорий + список фраз.
class CopyPage extends StatefulWidget {
  const CopyPage({super.key});

  @override
  State<CopyPage> createState() => _CopyPageState();
}

class _CopyPageState extends State<CopyPage> with SnackMixin {
  final _textCtrl = TextEditingController();
  final _searchCtrl = TextEditingController();
  final _chipScrollCtrl = ScrollController();
  final _phraseScrollCtrl = ScrollController();
  final _searchFocusNode = FocusNode();

  String? _lastCopiedId;
  Timer? _copyTimer;
  bool _showSearch = false;

  // Данные для Undo
  Phrase? _deletedPhrase;

  @override
  void dispose() {
    _textCtrl.dispose();
    _searchCtrl.dispose();
    _chipScrollCtrl.dispose();
    _phraseScrollCtrl.dispose();
    _searchFocusNode.dispose();
    _copyTimer?.cancel();
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
              checkError(p.lastError, () => p.clearError());
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
                checkError(p.lastError, () => p.clearError());
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _confirmDeletePhrase(PhraseProvider p, Phrase phrase) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Удалить фразу?'),
        content: Text(
          '«${phrase.text.length > 50 ? '${phrase.text.substring(0, 50)}…' : phrase.text}»',
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
              // Сохраняем для Undo
              _deletedPhrase = phrase;
              p.deletePhrase(phrase.id);
              checkError(p.lastError, () => p.clearError());
              showUndoSnack('Фраза удалена', () => _undoDeletePhrase());
            },
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }

  void _undoDeletePhrase() {
    final p = context.read<PhraseProvider>();
    if (_deletedPhrase != null) {
      p.addPhrase(_deletedPhrase!.text);
      _deletedPhrase = null;
    }
  }

  void _copyToClipboard(Phrase phrase) {
    Clipboard.setData(ClipboardData(text: phrase.text));
    _copyTimer?.cancel();
    setState(() => _lastCopiedId = phrase.id);
    _copyTimer = Timer(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _lastCopiedId = null);
    });
    showSnack(const Text('Скопировано!'));
  }

  void _pasteFromClipboard(PhraseProvider p) async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (!mounted) return;
    final text = data?.text;
    if (text != null && text.isNotEmpty) {
      await p.addPhrase(text);
      if (!mounted) return;
      checkError(p.lastError, () => p.clearError());
      showSnack(
        Text(
          'Вставлено: "${text.length > 30 ? '${text.substring(0, 30)}…' : text}"',
        ),
      );
    } else {
      showSnack(const Text('Буфер обмена пуст'));
    }
  }
  // --- Хоткеи ---

  void _handleCtrlF() {
    setState(() => _showSearch = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
      _searchCtrl.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _searchCtrl.text.length,
      );
    });
  }

  void _handleCtrlN() {
    _showPhraseDialog();
  }

  void _handleCtrlV() {
    final p = context.read<PhraseProvider>();
    _pasteFromClipboard(p);
  }

  void _handleEscape() {
    if (_searchCtrl.text.isNotEmpty) {
      _searchCtrl.clear();
      context.read<PhraseProvider>().setSearchQuery('');
    } else if (_showSearch) {
      setState(() => _showSearch = false);
    }
  }

  // --- Build ---

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PhraseProvider>();
    final showScrollToTop =
        _phraseScrollCtrl.hasClients && _phraseScrollCtrl.offset > 200;

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyF, control: true):
            _handleCtrlF,
        const SingleActivator(LogicalKeyboardKey.keyN, control: true):
            _handleCtrlN,
        const SingleActivator(LogicalKeyboardKey.keyV, control: true):
            _handleCtrlV,
        const SingleActivator(LogicalKeyboardKey.escape): _handleEscape,
      },
      child: Focus(
        autofocus: true,
        child: Stack(
          children: [
            Column(
              children: [
                _buildChipBar(provider),
                _buildSearchBar(provider),
                Expanded(child: _buildPhraseList(provider)),
              ],
            ),
            // FAB: новая фраза
            Positioned(
              right: 16,
              bottom: 16,
              child: FloatingActionButton(
                onPressed: _showPhraseDialog,
                tooltip: 'Новая фраза (Ctrl+N)',
                heroTag: 'addPhrase',
                child: const Icon(Icons.add),
              ),
            ),
            // Кнопка прокрутки вверх
            if (showScrollToTop)
              Positioned(
                left: 16,
                bottom: 16,
                child: FloatingActionButton.small(
                  onPressed: () {
                    _phraseScrollCtrl.animateTo(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                  heroTag: 'scrollToTop',
                  tooltip: 'В начало списка',
                  child: const Icon(Icons.keyboard_arrow_up),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // --- Чипсы категорий ---

  Widget _buildChipBar(PhraseProvider p) {
    final cats = p.categories;
    final activeId = p.activeCategory?.id;

    return Column(
      children: [
        SizedBox(
          height: 44,
          child: Row(
            children: [
              Expanded(
                child: ListView(
                  controller: _chipScrollCtrl,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  children: cats.map((cat) {
                    final count = p.phraseCounts[cat.id] ?? 0;
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: _chip(
                        label: '${cat.name}  $count',
                        selected: activeId == cat.id,
                        onTap: () => p.selectCategory(cat),
                        onSecondaryTap: () => _showCategoryMenu(p, cat),
                        onLongPress: () => _showCategoryMenu(p, cat),
                      ),
                    );
                  }).toList(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.content_paste, size: 18),
                tooltip: 'Вставить из буфера (Ctrl+V)',
                onPressed: () => _pasteFromClipboard(p),
              ),
              IconButton(
                icon: Icon(
                  _showSearch ? Icons.search_off : Icons.search,
                  size: 18,
                ),
                tooltip: _showSearch ? 'Скрыть поиск' : 'Поиск (Ctrl+F)',
                onPressed: () {
                  if (_showSearch) {
                    _searchCtrl.clear();
                    p.setSearchQuery('');
                  }
                  setState(() => _showSearch = !_showSearch);
                },
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, size: 20),
                tooltip: 'Новая папка',
                onPressed: _showAddCategoryDialog,
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: Theme.of(
            context,
          ).colorScheme.outlineVariant.withValues(alpha: 0.25),
        ),
      ],
    );
  }

  Widget _chip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    VoidCallback? onLongPress,
    VoidCallback? onSecondaryTap,
  }) {
    return GestureDetector(
      onLongPress: onLongPress,
      onSecondaryTap: onSecondaryTap,
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
              leading: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text(
                'Удалить',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
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
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: _showSearch
          ? Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
              child: TextField(
                controller: _searchCtrl,
                focusNode: _searchFocusNode,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Поиск… (Esc — закрыть)',
                  prefixIcon: const Icon(Icons.search, size: 18),
                  suffixIcon: _searchCtrl.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 16),
                          onPressed: () {
                            _searchCtrl.clear();
                            p.setSearchQuery('');
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.close, size: 16),
                          tooltip: 'Закрыть поиск',
                          onPressed: () {
                            setState(() => _showSearch = false);
                            _searchCtrl.clear();
                            p.setSearchQuery('');
                          },
                        ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: p.setSearchQuery,
              ),
            )
          : const SizedBox.shrink(),
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
            if (_searchCtrl.text.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Ctrl+N — добавить фразу',
                  style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                ),
              ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _phraseScrollCtrl,
      padding: const EdgeInsets.only(top: 2, bottom: 80),
      itemCount: p.phrases.length,
      itemBuilder: (_, i) {
        final phrase = p.phrases[i];
        return PhraseCard(
          key: ValueKey(phrase.id),
          id: phrase.id,
          text: phrase.text,
          isCopied: _lastCopiedId == phrase.id,
          onCopy: () => _copyToClipboard(phrase),
          onEdit: () =>
              _showPhraseDialog(id: phrase.id, initialText: phrase.text),
          onDelete: () => _confirmDeletePhrase(p, phrase),
        );
      },
    );
  }
}
