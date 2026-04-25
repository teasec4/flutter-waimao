import '../entities/phrase.dart';
import '../repositories/phrase_repository.dart';

class ManagePhrases {
  final PhraseRepository repository;

  ManagePhrases(this.repository);

  Future<List<Phrase>> loadPhrases({String? categoryId}) =>
      repository.getPhrases(categoryId: categoryId);

  Future<List<Phrase>> loadAllPhrases() => repository.getAllPhrases();

  Future<void> addPhrase(String text, {String? categoryId}) async {
    final phrase = Phrase(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      categoryId: categoryId,
    );
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
}
