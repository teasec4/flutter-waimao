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

  String? _lastError;
  String? get lastError => _lastError;

  PhraseProvider(this._managePhrases, this._manageCategories) {
    _loadCategories();
  }

  void clearError() {
    _lastError = null;
  }

  List<Phrase> get _filteredPhrases {
    var result = _phrases;

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      result = result
          .where((p) => p.text.toLowerCase().contains(query))
          .toList();
    }

    return result;
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // --- Loading ---

  Future<void> _loadCategories() async {
    try {
      _categories = await _manageCategories.getCategories();
      await _loadPhraseCounts();
      if (_categories.isNotEmpty && _activeCategory == null) {
        _activeCategory = _categories.first;
        await _refreshPhrases();
      }
      notifyListeners();
    } catch (e) {
      _lastError = 'Error loading categories: $e';
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
      await _refreshPhrases();
      notifyListeners();
    } catch (e) {
      _lastError = 'Error selecting category: $e';
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
      _lastError = 'Error loading phrases: $e';
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // --- Category management ---

  Future<void> addCategory(String name) async {
    try {
      final maxOrder = _categories.isEmpty
          ? 0
          : _categories
                    .map((c) => c.sortOrder)
                    .reduce((a, b) => a > b ? a : b) +
                1;
      await _manageCategories.addCategory(name, sortOrder: maxOrder);
      _categories = await _manageCategories.getCategories();
      final created = _categories.last;
      _activeCategory = created;
      await _refreshPhrases();
      await _loadPhraseCounts();
      notifyListeners();
    } catch (e) {
      _lastError = 'Error adding category: $e';
      notifyListeners();
    }
  }

  Future<void> renameCategory(String id, String newName) async {
    try {
      await _manageCategories.renameCategory(id, newName);
      _categories = await _manageCategories.getCategories();

      if (_activeCategory?.id == id) {
        _activeCategory = PhraseCategory(
          id: id,
          name: newName,
          sortOrder: _activeCategory!.sortOrder,
        );
      }
      notifyListeners();
    } catch (e) {
      _lastError = 'Error renaming category: $e';
      notifyListeners();
    }
  }

  Future<void> deleteCategory(String id) async {
    try {
      await _manageCategories.removeCategory(id);
      _categories = await _manageCategories.getCategories();
      await _loadPhraseCounts();

      if (_activeCategory?.id == id) {
        _activeCategory = _categories.isNotEmpty ? _categories.first : null;
        await _refreshPhrases();
      } else {
        notifyListeners();
      }
    } catch (e) {
      _lastError = 'Error deleting category: $e';
      notifyListeners();
    }
  }

  // --- Phrase management ---

  Future<void> addPhrase(String text) async {
    try {
      final maxOrder = _phrases.isEmpty
          ? 0
          : _phrases.map((p) => p.sortOrder).reduce((a, b) => a > b ? a : b) +
                1;
      await _managePhrases.addPhrase(
        text,
        categoryId: _activeCategory?.id,
        sortOrder: maxOrder,
      );
      await _refreshPhrases();
      await _loadPhraseCounts();
    } catch (e) {
      _lastError = 'Error adding phrase: $e';
      notifyListeners();
    }
  }

  Future<void> editPhrase(String id, String newText) async {
    try {
      await _managePhrases.editPhrase(id, newText);
      await _refreshPhrases();
    } catch (e) {
      _lastError = 'Error editing phrase: $e';
      notifyListeners();
    }
  }

  Future<void> deletePhrase(String id) async {
    try {
      await _managePhrases.deletePhrase(id);
      await _refreshPhrases();
      await _loadPhraseCounts();
    } catch (e) {
      _lastError = 'Error deleting phrase: $e';
      notifyListeners();
    }
  }
}
