import 'package:flutter/foundation.dart';
import 'package:paste_tool/domain/entities/dictionary_entry.dart';
import 'package:paste_tool/domain/usecases/search_dictionary.dart';

/// Состояние страницы словаря.
enum DictionaryStatus { initial, loading, success, error }

@immutable
class DictionaryState {
  final DictionaryStatus status;
  final List<DictionaryEntry> results;
  final String? errorMessage;
  final String query;

  const DictionaryState({
    this.status = DictionaryStatus.initial,
    this.results = const [],
    this.errorMessage,
    this.query = '',
  });

  DictionaryState copyWith({
    DictionaryStatus? status,
    List<DictionaryEntry>? results,
    String? errorMessage,
    String? query,
  }) {
    return DictionaryState(
      status: status ?? this.status,
      results: results ?? this.results,
      errorMessage: errorMessage,
      query: query ?? this.query,
    );
  }

  bool get isEmpty => results.isEmpty && status != DictionaryStatus.initial;
}

/// ViewModel для экрана словаря.
class DictionaryProvider extends ChangeNotifier {
  final SearchDictionary _searchDictionary;

  DictionaryState _state = const DictionaryState();
  DictionaryState get state => _state;

  DictionaryProvider(this._searchDictionary);

  Future<void> search(String query) async {
    final trimmed = query.trim();
    _state = _state.copyWith(
      query: query,
      status: trimmed.isEmpty ? DictionaryStatus.initial : DictionaryStatus.loading,
      results: [],
      errorMessage: null,
    );
    notifyListeners();

    if (trimmed.isEmpty) return;

    try {
      final results = await _searchDictionary(trimmed);
      _state = _state.copyWith(
        status: DictionaryStatus.success,
        results: results,
      );
    } catch (e) {
      _state = _state.copyWith(
        status: DictionaryStatus.error,
        errorMessage: 'Ошибка поиска: $e',
      );
    }

    notifyListeners();
  }

  void setQuery(String query) {
    _state = _state.copyWith(query: query);
    // Не вызываем notifyListeners — только обновляем query без перерисовки
  }

  void clear() {
    _state = const DictionaryState();
    notifyListeners();
  }
}
