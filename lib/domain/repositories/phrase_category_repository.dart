import '../entities/phrase_category.dart';

abstract class PhraseCategoryRepository {
  List<PhraseCategory> getCategories();
  void addCategory(PhraseCategory category);
  void renameCategory(String id, String newName);
  void removeCategory(String id);
  void reorder(List<PhraseCategory> categories);
}
