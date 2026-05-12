import '../entities/phrase_category.dart';

abstract class PhraseCategoryRepository {
  Future<List<PhraseCategory>> getCategories();
  Future<void> addCategory(PhraseCategory category);
  Future<void> renameCategory(String id, String newName);
  Future<void> removeCategory(String id);
}
