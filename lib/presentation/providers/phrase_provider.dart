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

  PhraseProvider(this._managePhrases, this._manageCategories) {
    _loadCategories();
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
    _ensureFavoritesCategory();
    _categories = _manageCategories.getCategories();
    // Избранное всегда первая
    final favIdx = _categories.indexWhere((c) => c.id == favoritesCategoryId);
    if (favIdx > 0) {
      final fav = _categories.removeAt(favIdx);
      _categories.insert(0, fav);
    }
    // Если нет категорий — проверяем, был ли ап
    if (_categories.isEmpty) {
      _ensureFavoritesCategory();
      _categories = _manageCategories.getCategories();
    }
    notifyListeners();
  }

  void _ensureFavoritesCategory() {
    final cats = _manageCategories.getCategories();
    if (!cats.any((c) => c.id == favoritesCategoryId)) {
      _manageCategories.addCategoryRaw(
        PhraseCategory(
          id: favoritesCategoryId,
          name: 'Избранное',
          sortOrder: 0,
        ),
      );
    }
  }

  Future<void> selectCategory(PhraseCategory? category) async {
    _activeCategory = category;
    _searchQuery = '';

    if (category?.id == favoritesCategoryId) {
      // Показываем все избранные фразы
      await _loadAllPhrases();
      _phrases = _allPhrases.where((p) => p.isFavorite).toList();
    } else {
      await _refreshPhrases();
    }
    notifyListeners();
  }

  Future<void> _refreshPhrases() async {
    _loading = true;
    notifyListeners();

    _phrases = await _managePhrases.loadPhrases(
      categoryId: _activeCategory?.id,
    );

    _loading = false;
    notifyListeners();
  }

  Future<void> _loadAllPhrases() async {
    _loading = true;
    notifyListeners();

    _allPhrases = await _managePhrases.loadAllPhrases();

    _loading = false;
    notifyListeners();
  }

  // --- Управление категориями ---

  Future<void> addCategory(String name) async {
    _manageCategories.addCategory(name);
    _categories = _manageCategories.getCategories();
    notifyListeners();
  }

  Future<void> renameCategory(String id, String newName) async {
    if (id == favoritesCategoryId) return; // нельзя переименовать избранное
    _manageCategories.renameCategory(id, newName);
    _categories = _manageCategories.getCategories();

    if (_activeCategory?.id == id) {
      _activeCategory =
          PhraseCategory(id: id, name: newName, sortOrder: _activeCategory!.sortOrder);
    }
    notifyListeners();
  }

  bool canDeleteCategory(String id) => id != favoritesCategoryId;

  Future<void> deleteCategory(String id) async {
    if (id == favoritesCategoryId) return; // нельзя удалить избранное
    _manageCategories.removeCategory(id);
    _categories = _manageCategories.getCategories();

    if (_activeCategory?.id == id) {
      _activeCategory = null;
      await _refreshPhrases();
    } else {
      notifyListeners();
    }
  }

  // --- Управление фразами ---

  Future<void> addPhrase(String text) async {
    await _managePhrases.addPhrase(text, categoryId: _activeCategory?.id);
    if (isFavoritesCategory) {
      await _loadAllPhrases();
      _phrases = _allPhrases.where((p) => p.isFavorite).toList();
    } else {
      await _refreshPhrases();
    }
  }

  Future<void> editPhrase(String id, String newText) async {
    await _managePhrases.editPhrase(id, newText);
    if (isFavoritesCategory) {
      await _loadAllPhrases();
      _phrases = _allPhrases.where((p) => p.isFavorite).toList();
    } else {
      await _refreshPhrases();
    }
  }

  Future<void> toggleFavorite(String id, bool isFavorite) async {
    await _managePhrases.toggleFavorite(id, isFavorite);

    if (isFavoritesCategory) {
      await _loadAllPhrases();
      _phrases = _allPhrases.where((p) => p.isFavorite).toList();
    } else {
      await _refreshPhrases();
    }
  }

  Future<void> deletePhrase(String id) async {
    await _managePhrases.deletePhrase(id);
    if (isFavoritesCategory) {
      await _loadAllPhrases();
      _phrases = _allPhrases.where((p) => p.isFavorite).toList();
    } else {
      await _refreshPhrases();
    }
  }
}
