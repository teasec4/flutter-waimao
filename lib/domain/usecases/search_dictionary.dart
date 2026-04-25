import 'package:paste_tool/domain/entities/dictionary_entry.dart';
import 'package:paste_tool/domain/repositories/dictionary_repository.dart';

class SearchDictionary {
  final DictionaryRepository _repository;

  SearchDictionary({required DictionaryRepository repository})
      : _repository = repository;

  Future<List<DictionaryEntry>> call(String query) =>
      _repository.search(query);
}
