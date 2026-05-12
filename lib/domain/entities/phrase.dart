class Phrase {
  final String id;
  final String text;
  final String? categoryId;
  final bool isFavorite;
  final int sortOrder;

  const Phrase({
    required this.id,
    required this.text,
    this.categoryId,
    this.isFavorite = false,
    this.sortOrder = 0,
  });

  Phrase copyWith({String? text, bool? isFavorite, int? sortOrder}) => Phrase(
        id: id,
        text: text ?? this.text,
        categoryId: categoryId,
        isFavorite: isFavorite ?? this.isFavorite,
        sortOrder: sortOrder ?? this.sortOrder,
      );
}
