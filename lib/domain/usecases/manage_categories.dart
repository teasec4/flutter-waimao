import 'package:uuid/uuid.dart';

import '../entities/phrase_category.dart';
import '../repositories/phrase_category_repository.dart';
import '../repositories/phrase_repository.dart';

const _uuid = Uuid();

class ManageCategories {
  final PhraseCategoryRepository repository;
  final PhraseRepository _phraseRepository;

  ManageCategories(this.repository, this._phraseRepository);

  Future<List<PhraseCategory>> getCategories() => repository.getCategories();

  Future<void> addCategory(String name, {int sortOrder = 0}) async {
    final category = PhraseCategory(
      id: _uuid.v4(),
      name: name,
      sortOrder: sortOrder,
    );
    await repository.addCategory(category);
  }

  Future<void> addCategoryRaw(PhraseCategory category) {
    return repository.addCategory(category);
  }

  Future<void> renameCategory(String id, String newName) {
    return repository.renameCategory(id, newName);
  }

  Future<void> removeCategory(String id) async {
    await repository.removeCategory(id);
    await _phraseRepository.deletePhrasesByCategory(id);
  }

  Future<void> reorder(List<PhraseCategory> categories) =>
      repository.reorder(categories);
}
