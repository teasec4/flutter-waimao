import 'package:flutter/foundation.dart';
import 'package:paste_tool/domain/entities/phrase.dart';
import 'package:paste_tool/domain/entities/phrase_category.dart';
import 'package:paste_tool/domain/usecases/manage_phrases.dart';
import 'package:paste_tool/domain/usecases/manage_categories.dart';

class PhraseProvider extends ChangeNotifier {
  final ManagePhrases _managePhrases;
  final ManageCategories _manageCategories;

  List<Phrase> _phrases = [];
  List<Phrase> get phrases => _filteredPhrases;

  List<Phrase> _allPhrases = [];

  List<PhraseCategory> _categories = [];
  List<PhraseCategory> get categories => _categories;

  PhraseCategory? _activeCategory;
  PhraseCategory? get activeCategory => _activeCategory;

  bool _loading = false;
  bool get loading => _loading;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  bool _showFavorites = false;
  bool get showFavorites => _showFavorites;

  PhraseProvider(this._managePhrases, this._manageCategories) {
    _loadCategories();
  }

  /// Отфильтрованные фразы (поиск + избранное)
  List<Phrase> get _filteredPhrases {
    var result = _showFavorites ? _allPhrases.where((p) => p.isFavorite).toList() : _phrases;

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      result = result.where((p) => p.text.toLowerCase().contains(query)).toList();
    }

    return result;
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleFavoritesView() {
    _showFavorites = !_showFavorites;
    if (_showFavorites) {
      _activeCategory = null;
      _loadAllPhrases();
    } else {
      notifyListeners();
    }
  }

  // --- Загрузка ---

  Future<void> _loadCategories() async {
    _categories = _manageCategories.getCategories();
    notifyListeners();
  }

  Future<void> selectCategory(PhraseCategory? category) async {
    _activeCategory = category;
    _showFavorites = false;
    _searchQuery = '';
    await _refreshPhrases();
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
    _manageCategories.renameCategory(id, newName);
    _categories = _manageCategories.getCategories();

    if (_activeCategory?.id == id) {
      _activeCategory =
          PhraseCategory(id: id, name: newName, sortOrder: _activeCategory!.sortOrder);
    }
    notifyListeners();
  }

  Future<void> deleteCategory(String id) async {
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
    if (_showFavorites) {
      await _loadAllPhrases();
    } else {
      await _refreshPhrases();
    }
  }

  Future<void> editPhrase(String id, String newText) async {
    await _managePhrases.editPhrase(id, newText);
    if (_showFavorites) {
      await _loadAllPhrases();
    } else {
      await _refreshPhrases();
    }
  }

  Future<void> toggleFavorite(String id, bool isFavorite) async {
    await _managePhrases.toggleFavorite(id, isFavorite);
    if (_showFavorites) {
      await _loadAllPhrases();
    } else {
      await _refreshPhrases();
    }
  }

  Future<void> deletePhrase(String id) async {
    await _managePhrases.deletePhrase(id);
    if (_showFavorites) {
      await _loadAllPhrases();
    } else {
      await _refreshPhrases();
    }
  }
}
