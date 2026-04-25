class DictionaryMeaning {
  final int id;
  final int level;
  final String text;
  final int orderNum;

  const DictionaryMeaning({
    required this.id,
    this.level = 0,
    required this.text,
    this.orderNum = 0,
  });
}

class DictionaryEntry {
  final int id;
  final String simplified;
  final String pinyin;
  final List<DictionaryMeaning> meanings;
  bool isFavorite;

  DictionaryEntry({
    required this.id,
    required this.simplified,
    this.pinyin = '',
    required this.meanings,
    this.isFavorite = false,
  });

  String get russian => meanings.isNotEmpty
      ? meanings.map((m) => m.text).join('; ')
      : '';
}
