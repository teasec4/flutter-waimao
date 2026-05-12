import 'package:flutter/foundation.dart';
import 'package:paste_tool/domain/entities/phrase.dart';
import 'package:paste_tool/domain/entities/phrase_category.dart';
import 'package:paste_tool/domain/usecases/manage_phrases.dart';
import 'package:paste_tool/domain/usecases/manage_categories.dart';

class PhraseProvider extends ChangeNotifier {
  final ManagePhrases _managePhrases;
  final ManageCategories _manageCategories;

  static const favoritesCategoryId = 'favorites';

  List<Phrase> _phrases = [];
  List<Phrase> get phrases => _filteredPhrases;

  List<Phrase> _allPhrases = [];
  List<Phrase> get allPhrases => _allPhrases;

  List<PhraseCategory> _categories = [];
  List<PhraseCategory> get categories => _categories;

  PhraseCategory? _activeCategory;
  PhraseCategory? get activeCategory => _activeCategory;

  bool _loading = false;
  bool get loading => _loading;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  Map<String, int> _phraseCounts = {};
  Map<String, int> get phraseCounts => _phraseCounts;

  // Undo для удаления
  Phrase? _undoPhrase;

  PhraseCategory? _undoCategory;
  List<Phrase> _undoPhrasesForCategory = [];

  String? _lastError;
  String? get lastError => _lastError;

  PhraseProvider(this._managePhrases, this._manageCategories) {
    _loadCategories();
  }

  void clearError() {
    _lastError = null;
  }

  /// Отфильтрованные фразы (поиск)
  List<Phrase> get _filteredPhrases {
    var result = _phrases;

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      result = result.where((p) => p.text.toLowerCase().contains(query)).toList();
    }

    return result;
  }

  bool get isFavoritesCategory =>
      _activeCategory?.id == favoritesCategoryId;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // --- Загрузка ---

  Future<void> _loadCategories() async {
    try {
      _ensureFavoritesCategory();
      _categories = await _manageCategories.getCategories();
      // Избранное всегда первая
      final favIdx = _categories.indexWhere((c) => c.id == favoritesCategoryId);
      if (favIdx > 0) {
        final fav = _categories.removeAt(favIdx);
        _categories.insert(0, fav);
      }
      // Если нет категорий — проверяем, был ли ап
      if (_categories.isEmpty) {
        _ensureFavoritesCategory();
        _categories = await _manageCategories.getCategories();
      }
      await _loadPhraseCounts();
      notifyListeners();
    } catch (e) {
      _lastError = 'Ошибка загрузки категорий: $e';
      notifyListeners();
    }
  }

  Future<void> _ensureFavoritesCategory() async {
    try {
      final cats = await _manageCategories.getCategories();
      if (!cats.any((c) => c.id == favoritesCategoryId)) {
        await _manageCategories.addCategoryRaw(
          PhraseCategory(
            id: favoritesCategoryId,
            name: 'Избранное',
            sortOrder: 0,
          ),
        );
      }
    } catch (e) {
      _lastError = 'Ошибка создания категории "Избранное": $e';
      notifyListeners();
    }
  }

  Future<void> _loadPhraseCounts() async {
    _phraseCounts = {};
    for (final cat in _categories) {
      final count = await _managePhrases.countPhrasesByCategory(cat.id);
      _phraseCounts[cat.id] = count;
    }
  }

  Future<void> selectCategory(PhraseCategory? category) async {
    _activeCategory = category;
    _searchQuery = '';

    try {
      if (category?.id == favoritesCategoryId) {
        // Показываем все избранные фразы
        await _loadAllPhrases();
        _phrases = _allPhrases.where((p) => p.isFavorite).toList();
      } else {
        await _refreshPhrases();
      }
      notifyListeners();
    } catch (e) {
      _lastError = 'Ошибка выбора категории: $e';
      notifyListeners();
    }
  }

  Future<void> _refreshPhrases() async {
    _loading = true;
    notifyListeners();

    try {
      _phrases = await _managePhrases.loadPhrases(
        categoryId: _activeCategory?.id,
      );
    } catch (e) {
      _lastError = 'Ошибка загрузки фраз: $e';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> _loadAllPhrases() async {
    _loading = true;
    notifyListeners();

    try {
      _allPhrases = await _managePhrases.loadAllPhrases();
    } catch (e) {
      _lastError = 'Ошибка загрузки всех фраз: $e';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // --- Управление категориями ---

  Future<void> addCategory(String name) async {
    try {
      await _manageCategories.addCategory(name);
      _categories = await _manageCategories.getCategories();
      notifyListeners();
    } catch (e) {
      _lastError = 'Ошибка добавления категории: $e';
      notifyListeners();
    }
  }

  Future<void> renameCategory(String id, String newName) async {
    if (id == favoritesCategoryId) return; // нельзя переименовать избранное
    try {
      await _manageCategories.renameCategory(id, newName);
      _categories = await _manageCategories.getCategories();

      if (_activeCategory?.id == id) {
        _activeCategory =
            PhraseCategory(id: id, name: newName, sortOrder: _activeCategory!.sortOrder);
      }
      notifyListeners();
    } catch (e) {
      _lastError = 'Ошибка переименования категории: $e';
      notifyListeners();
    }
  }

  bool canDeleteCategory(String id) => id != favoritesCategoryId;

  Future<void> deleteCategory(String id) async {
    if (id == favoritesCategoryId) return; // нельзя удалить избранное
    try {
      // Сохраняем backup для undo
      _undoCategory = _categories.firstWhere(
        (c) => c.id == id,
        orElse: () => throw Exception('Категория не найдена'),
      );
      _undoPhrasesForCategory =
          await _managePhrases.loadPhrases(categoryId: id);

      await _manageCategories.removeCategory(id);
      _categories = await _manageCategories.getCategories();
      await _loadPhraseCounts();

      if (_activeCategory?.id == id) {
        _activeCategory = null;
        await _refreshPhrases();
      } else {
        notifyListeners();
      }
    } catch (e) {
      _undoCategory = null;
      _undoPhrasesForCategory = [];
      _lastError = 'Ошибка удаления категории: $e';
      notifyListeners();
    }
  }

  Future<void> undoDeleteCategory() async {
    final cat = _undoCategory;
    final phrases = List<Phrase>.from(_undoPhrasesForCategory);
    _undoCategory = null;
    _undoPhrasesForCategory = [];
    if (cat == null) return;

    try {
      await _manageCategories.addCategoryRaw(cat);
      for (final phrase in phrases) {
        await _managePhrases.addPhraseRaw(phrase);
      }
      _categories = await _manageCategories.getCategories();
      await _loadPhraseCounts();

      if (_activeCategory?.id == cat.id) {
        await _refreshPhrases();
        notifyListeners();
      } else {
        notifyListeners();
      }
    } catch (e) {
      _lastError = 'Ошибка восстановления категории: $e';
      notifyListeners();
    }
  }

  // --- Управление фразами ---

  Future<void> addPhrase(String text) async {
    try {
      await _managePhrases.addPhrase(text, categoryId: _activeCategory?.id);
      if (isFavoritesCategory) {
        await _loadAllPhrases();
        _phrases = _allPhrases.where((p) => p.isFavorite).toList();
      } else {
        await _refreshPhrases();
      }
      await _loadPhraseCounts();
    } catch (e) {
      _lastError = 'Ошибка добавления фразы: $e';
      notifyListeners();
    }
  }

  Future<void> editPhrase(String id, String newText) async {
    try {
      await _managePhrases.editPhrase(id, newText);
      if (isFavoritesCategory) {
        await _loadAllPhrases();
        _phrases = _allPhrases.where((p) => p.isFavorite).toList();
      } else {
        await _refreshPhrases();
      }
    } catch (e) {
      _lastError = 'Ошибка редактирования фразы: $e';
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(String id, bool isFavorite) async {
    try {
      await _managePhrases.toggleFavorite(id, isFavorite);
      if (isFavoritesCategory) {
        await _loadAllPhrases();
        _phrases = _allPhrases.where((p) => p.isFavorite).toList();
      } else {
        await _refreshPhrases();
      }
    } catch (e) {
      _lastError = 'Ошибка изменения избранного: $e';
      notifyListeners();
    }
  }

  Future<void> deletePhrase(String id) async {
    try {
      // Сохраняем backup для undo
      _undoPhrase = _phrases.firstWhere(
        (p) => p.id == id,
        orElse: () => _allPhrases.firstWhere(
          (p) => p.id == id,
          orElse: () => throw Exception('Фраза не найдена'),
        ),
      );

      await _managePhrases.deletePhrase(id);
      if (isFavoritesCategory) {
        await _loadAllPhrases();
        _phrases = _allPhrases.where((p) => p.isFavorite).toList();
      } else {
        await _refreshPhrases();
      }
      await _loadPhraseCounts();
    } catch (e) {
      _undoPhrase = null;
      _lastError = 'Ошибка удаления фразы: $e';
      notifyListeners();
    }
  }

  Future<void> undoDeletePhrase() async {
    final backup = _undoPhrase;
    _undoPhrase = null;
    if (backup == null) return;

    try {
      await _managePhrases.addPhraseRaw(backup);
      if (isFavoritesCategory) {
        await _loadAllPhrases();
        _phrases = _allPhrases.where((p) => p.isFavorite).toList();
      } else {
        await _refreshPhrases();
      }
      await _loadPhraseCounts();
    } catch (e) {
      _lastError = 'Ошибка восстановления фразы: $e';
      notifyListeners();
    }
  }
}
