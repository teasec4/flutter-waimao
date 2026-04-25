class DictionaryEntry {
  final String id;
  final String headword; // 中文
  final String pinyin;
  final List<String> translations; // переводы на русский

  const DictionaryEntry({
    required this.id,
    required this.headword,
    required this.pinyin,
    required this.translations,
  });
}
