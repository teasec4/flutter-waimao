class PhraseCategory {
  final String id;
  final String name;
  final int sortOrder;

  const PhraseCategory({
    required this.id,
    required this.name,
    this.sortOrder = 0,
  });
}
