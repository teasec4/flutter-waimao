import 'package:flutter/foundation.dart';
import 'package:paste_tool/domain/entities/dictionary_entry.dart';
import 'package:paste_tool/domain/usecases/search_dictionary.dart';

class DictionaryProvider extends ChangeNotifier {
  final SearchDictionary _searchDictionary;

  List<DictionaryEntry> _allEntries = [];
  List<DictionaryEntry> get allEntries => _allEntries;

  List<DictionaryEntry> _filteredEntries = [];
  List<DictionaryEntry> get filteredEntries => _filteredEntries;

  String _query = '';
  String get query => _query;

  bool _showFavorites = false;
  bool get showFavorites => _showFavorites;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool get isEmpty =>
      _showFavorites ? _filteredEntries.isEmpty : _allEntries.isEmpty;

  DictionaryProvider(this._searchDictionary) {
    _loadAll();
  }

  Future<void> _loadAll() async {
    _isLoading = true;
    notifyListeners();
    _allEntries = await _searchDictionary.getAll();
    _isLoading = false;
    _applyFilter();
  }

  Future<void> _applyFilter() async {
    _isLoading = true;
    notifyListeners();

    List<DictionaryEntry> result;
    if (_showFavorites) {
      result = await _searchDictionary.getFavorites();
    } else if (_query.isNotEmpty) {
      result = await _searchDictionary.search(_query);
    } else {
      result = _allEntries;
    }

    _filteredEntries = result;
    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    _query = query;
    _applyFilter();
  }

  void toggleFavorites() {
    _showFavorites = !_showFavorites;
    // При переключении на избранное очищаем строку поиска
    if (_showFavorites) {
      _query = '';
    }
    _applyFilter();
  }

  void toggleFavorite(int entryId) {
    _searchDictionary.toggleFavorite(entryId);
    // Обновляем состояние в локальном списке
    final idx = _allEntries.indexWhere((e) => e.id == entryId);
    if (idx != -1) {
      _allEntries[idx].isFavorite = !_allEntries[idx].isFavorite;
    }
    // Обновляем отображение
    _applyFilter();
  }
}
