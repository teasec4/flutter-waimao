import 'package:isar_community/isar.dart';
import 'package:paste_tool/domain/entities/phrase.dart';

part 'phrase_collection.g.dart';

@collection
class PhraseCollection {
  Id id = Isar.autoIncrement;

  @Index()
  late String uuid;

  late String text;
  late String? categoryId;
  late int sortOrder;

  Phrase toEntity() => Phrase(
    id: uuid,
    text: text,
    categoryId: categoryId,
    sortOrder: sortOrder,
  );

  static PhraseCollection fromEntity(Phrase entity) => PhraseCollection()
    ..uuid = entity.id
    ..text = entity.text
    ..categoryId = entity.categoryId
    ..sortOrder = entity.sortOrder;
}
