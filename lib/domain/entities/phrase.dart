class Phrase {
  final String id;
  final String text;
  final String? categoryId;
  final bool isFavorite;

  const Phrase({
    required this.id,
    required this.text,
    this.categoryId,
    this.isFavorite = false,
  });

  Phrase copyWith({String? text, bool? isFavorite}) => Phrase(
        id: id,
        text: text ?? this.text,
        categoryId: categoryId,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}
