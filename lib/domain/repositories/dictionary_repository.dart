import '../entities/dictionary_entry.dart';

abstract class DictionaryRepository {
  /// Поиск по запросу в упрощённых иероглифах, пиньине и переводе
  Future<List<DictionaryEntry>> search(String query);

  /// Добавить/убрать из избранного (id — номер записи в БД)
  void toggleFavorite(int entryId);

  /// Получить список избранных
  Future<List<DictionaryEntry>> getFavorites();

  /// Получить все записи (для первоначальной загрузки)
  Future<List<DictionaryEntry>> getAll();
}
