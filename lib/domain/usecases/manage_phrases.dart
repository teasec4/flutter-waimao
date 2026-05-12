import 'package:uuid/uuid.dart';

import '../entities/phrase.dart';
import '../repositories/phrase_repository.dart';

const _uuid = Uuid();

class ManagePhrases {
  final PhraseRepository repository;

  ManagePhrases(this.repository);

  Future<List<Phrase>> loadPhrases({String? categoryId}) =>
      repository.getPhrases(categoryId: categoryId);

  Future<List<Phrase>> loadAllPhrases() => repository.getAllPhrases();

  Future<void> addPhrase(String text, {String? categoryId, int sortOrder = 0}) async {
    final phrase = Phrase(
      id: _uuid.v4(),
      text: text,
      categoryId: categoryId,
      sortOrder: sortOrder,
    );
    await repository.addPhrase(phrase);
  }

  Future<void> addPhraseRaw(Phrase phrase) async {
    await repository.addPhrase(phrase);
  }

  Future<void> editPhrase(String id, String newText) async {
    await repository.editPhrase(id, newText);
  }

  Future<void> toggleFavorite(String id, bool isFavorite) async {
    await repository.updatePhraseFavorite(id, isFavorite);
  }

  Future<void> deletePhrase(String id) async {
    await repository.deletePhrase(id);
  }

  Future<int> countPhrasesByCategory(String categoryId) =>
      repository.countPhrasesByCategory(categoryId);

}
