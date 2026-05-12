import '../entities/phrase.dart';

abstract class PhraseRepository {
  Future<List<Phrase>> getPhrases({String? categoryId});
  Future<List<Phrase>> getAllPhrases();
  Future<void> addPhrase(Phrase phrase);
  Future<void> editPhrase(String id, String text);
  Future<void> updatePhraseFavorite(String id, bool isFavorite);
  Future<void> deletePhrase(String id);
  Future<void> deletePhrasesByCategory(String categoryId);
  Future<int> countPhrasesByCategory(String categoryId);
  Future<void> reorderPhrases(List<Phrase> phrases);
}
