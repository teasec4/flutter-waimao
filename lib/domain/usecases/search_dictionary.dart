import '../entities/dictionary_entry.dart';
import '../repositories/dictionary_repository.dart';

class SearchDictionary {
  final DictionaryRepository repository;

  SearchDictionary(this.repository);

  Future<List<DictionaryEntry>> getAll() => repository.getAll();

  Future<List<DictionaryEntry>> search(String query) => repository.search(query);

  Future<List<DictionaryEntry>> getFavorites() => repository.getFavorites();

  void toggleFavorite(int entryId) => repository.toggleFavorite(entryId);
}
