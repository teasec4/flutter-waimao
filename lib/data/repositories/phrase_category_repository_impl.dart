import 'package:isar_community/isar.dart';
import 'package:paste_tool/data/collections/phrase_category_collection.dart';
import 'package:paste_tool/domain/entities/phrase_category.dart';
import 'package:paste_tool/domain/repositories/phrase_category_repository.dart';

class PhraseCategoryRepositoryImpl implements PhraseCategoryRepository {
  final Isar isar;

  PhraseCategoryRepositoryImpl({required this.isar});

  @override
  List<PhraseCategory> getCategories() {
    return isar.phraseCategoryCollections
        .where()
        .sortBySortOrder()
        .findAllSync()
        .map((c) => c.toEntity())
        .toList();
  }

  @override
  void addCategory(PhraseCategory category) {
    final collection = PhraseCategoryCollection.fromEntity(category);
    isar.writeTxnSync(() => isar.phraseCategoryCollections.putSync(collection));
  }

  @override
  void renameCategory(String id, String newName) {
    final existing = isar.phraseCategoryCollections
        .filter()
        .uuidEqualTo(id)
        .findAllSync();
    if (existing.isNotEmpty) {
      isar.writeTxnSync(() {
        existing.first.name = newName;
        isar.phraseCategoryCollections.putSync(existing.first);
      });
    }
  }

  @override
  void removeCategory(String id) {
    final existing = isar.phraseCategoryCollections
        .filter()
        .uuidEqualTo(id)
        .findAllSync();
    if (existing.isNotEmpty) {
      isar.writeTxnSync(
        () => isar.phraseCategoryCollections.deleteAllSync(
          existing.map((e) => e.id).toList(),
        ),
      );
    }
  }

  @override
  void reorder(List<PhraseCategory> categories) {
    isar.writeTxnSync(() {
      for (var i = 0; i < categories.length; i++) {
        final collection = PhraseCategoryCollection.fromEntity(
          PhraseCategory(
            id: categories[i].id,
            name: categories[i].name,
            sortOrder: i,
          ),
        );
        isar.phraseCategoryCollections.putSync(collection);
      }
    });
  }
}
