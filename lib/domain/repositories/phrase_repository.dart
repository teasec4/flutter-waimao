import '../entities/phrase.dart';

abstract class PhraseRepository {
  Future<List<Phrase>> getPhrases({String? categoryId});
  Future<void> addPhrase(Phrase phrase);
  Future<void> editPhrase(String id, String text);
  Future<void> deletePhrase(String id);
  Future<void> deletePhrasesByCategory(String categoryId);
  Future<int> countPhrasesByCategory(String categoryId);
}
