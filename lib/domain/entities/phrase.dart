class Phrase {
  final String id;
  final String text;
  final String? categoryId;
  final int sortOrder;

  const Phrase({
    required this.id,
    required this.text,
    this.categoryId,
    this.sortOrder = 0,
  });
}
