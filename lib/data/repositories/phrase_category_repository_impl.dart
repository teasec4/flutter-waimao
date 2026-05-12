import 'package:isar_community/isar.dart';
import 'package:paste_tool/data/collections/phrase_category_collection.dart';
import 'package:paste_tool/domain/entities/phrase_category.dart';
import 'package:paste_tool/domain/repositories/phrase_category_repository.dart';

class PhraseCategoryRepositoryImpl implements PhraseCategoryRepository {
  final Isar isar;

  PhraseCategoryRepositoryImpl({required this.isar});

  @override
  Future<List<PhraseCategory>> getCategories() async {
    return isar.phraseCategoryCollections
        .where()
        .sortBySortOrder()
        .findAll()
        .then((list) => list.map((c) => c.toEntity()).toList());
  }

  @override
  Future<void> addCategory(PhraseCategory category) async {
    final collection = PhraseCategoryCollection.fromEntity(category);
    await isar.writeTxn(() => isar.phraseCategoryCollections.put(collection));
  }

  @override
  Future<void> renameCategory(String id, String newName) async {
    final existing = await isar.phraseCategoryCollections
        .filter()
        .uuidEqualTo(id)
        .findAll();
    if (existing.isNotEmpty) {
      await isar.writeTxn(() async {
        existing.first.name = newName;
        await isar.phraseCategoryCollections.put(existing.first);
      });
    }
  }

  @override
  Future<void> removeCategory(String id) async {
    final existing = await isar.phraseCategoryCollections
        .filter()
        .uuidEqualTo(id)
        .findAll();
    if (existing.isNotEmpty) {
      await isar.writeTxn(() async {
        await isar.phraseCategoryCollections.deleteAll(
          existing.map((e) => e.id).toList(),
        );
      });
    }
  }

  @override
  Future<void> reorder(List<PhraseCategory> categories) async {
    await isar.writeTxn(() async {
      for (var i = 0; i < categories.length; i++) {
        final collection = PhraseCategoryCollection.fromEntity(
          PhraseCategory(
            id: categories[i].id,
            name: categories[i].name,
            sortOrder: i,
          ),
        );
        await isar.phraseCategoryCollections.put(collection);
      }
    });
  }
}
