import 'package:isar_community/isar.dart';
import 'package:paste_tool/data/collections/phrase_collection.dart';
import 'package:paste_tool/domain/entities/phrase.dart';
import 'package:paste_tool/domain/repositories/phrase_repository.dart';

class PhraseRepositoryImpl implements PhraseRepository {
  final Isar isar;

  PhraseRepositoryImpl({required this.isar});

  @override
  Future<List<Phrase>> getPhrases({String? categoryId}) async {
    if (categoryId == null) {
      return isar.phraseCollections
          .filter()
          .categoryIdIsNull()
          .sortBySortOrder()
          .findAll()
          .then((list) => list.map((c) => c.toEntity()).toList());
    }
    return isar.phraseCollections
        .filter()
        .categoryIdEqualTo(categoryId)
        .sortBySortOrder()
        .findAll()
        .then((list) => list.map((c) => c.toEntity()).toList());
  }

  @override
  Future<List<Phrase>> getAllPhrases() async {
    return isar.phraseCollections
        .where()
        .sortBySortOrder()
        .findAll()
        .then(
          (list) => list.map((c) => c.toEntity()).toList(),
        );
  }

  @override
  Future<void> addPhrase(Phrase phrase) async {
    final collection = PhraseCollection.fromEntity(phrase);
    await isar.writeTxn(() => isar.phraseCollections.put(collection));
  }

  @override
  Future<void> editPhrase(String id, String text) async {
    final existing =
        await isar.phraseCollections.filter().uuidEqualTo(id).findAll();
    if (existing.isNotEmpty) {
      await isar.writeTxn(() {
        existing.first.text = text;
        return isar.phraseCollections.put(existing.first);
      });
    }
  }

  @override
  Future<void> updatePhraseFavorite(String id, bool isFavorite) async {
    final existing =
        await isar.phraseCollections.filter().uuidEqualTo(id).findAll();
    if (existing.isNotEmpty) {
      await isar.writeTxn(() {
        existing.first.isFavorite = isFavorite;
        return isar.phraseCollections.put(existing.first);
      });
    }
  }

  @override
  Future<void> deletePhrase(String id) async {
    final existing =
        await isar.phraseCollections.filter().uuidEqualTo(id).findAll();
    if (existing.isNotEmpty) {
      await isar.writeTxn(
        () => isar.phraseCollections.deleteAll(
          existing.map((e) => e.id).toList(),
        ),
      );
    }
  }

  @override
  Future<void> deletePhrasesByCategory(String categoryId) async {
    final existing = await isar.phraseCollections
        .filter()
        .categoryIdEqualTo(categoryId)
        .findAll();
    if (existing.isNotEmpty) {
      await isar.writeTxn(
        () => isar.phraseCollections.deleteAll(
          existing.map((e) => e.id).toList(),
        ),
      );
    }
  }

  @override
  Future<int> countPhrasesByCategory(String categoryId) async {
    return isar.phraseCollections
        .filter()
        .categoryIdEqualTo(categoryId)
        .count();
  }

  @override
  Future<void> reorderPhrases(List<Phrase> phrases) async {
    await isar.writeTxn(() async {
      for (var i = 0; i < phrases.length; i++) {
        final collection = PhraseCollection.fromEntity(
          Phrase(
            id: phrases[i].id,
            text: phrases[i].text,
            categoryId: phrases[i].categoryId,
            isFavorite: phrases[i].isFavorite,
            sortOrder: i,
          ),
        );
        await isar.phraseCollections.put(collection);
      }
    });
  }
}
