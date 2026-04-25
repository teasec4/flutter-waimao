import '../entities/phrase_category.dart';
import '../repositories/phrase_category_repository.dart';

class ManageCategories {
  final PhraseCategoryRepository repository;

  ManageCategories(this.repository);

  List<PhraseCategory> getCategories() => repository.getCategories();

  void addCategoryRaw(PhraseCategory category) {
    repository.addCategory(category);
  }

  void addCategory(String name) {
    final category = PhraseCategory(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      sortOrder: repository.getCategories().length,
    );
    repository.addCategory(category);
  }

  void renameCategory(String id, String newName) {
    repository.renameCategory(id, newName);
  }

  void removeCategory(String id) {
    repository.removeCategory(id);
  }
}
