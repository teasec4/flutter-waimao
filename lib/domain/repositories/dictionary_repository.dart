import 'package:paste_tool/domain/entities/dictionary_entry.dart';

/// Репозиторий словаря.
///
/// Реализация переключится на HTTP API к dabkrs backend.
abstract class DictionaryRepository {
  /// Поиск записей по запросу.
  /// [query] — китайское слово или его часть.
  Future<List<DictionaryEntry>> search(String query);
}
