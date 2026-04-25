import 'package:isar_community/isar.dart';
import 'package:paste_tool/domain/entities/phrase_category.dart';

part 'phrase_category_collection.g.dart';

@collection
class PhraseCategoryCollection {
  Id id = Isar.autoIncrement;

  @Index()
  late String uuid;

  late String name;
  late int sortOrder;

  PhraseCategory toEntity() => PhraseCategory(
        id: uuid,
        name: name,
        sortOrder: sortOrder,
      );

  static PhraseCategoryCollection fromEntity(PhraseCategory entity) =>
      PhraseCategoryCollection()
        ..uuid = entity.id
        ..name = entity.name
        ..sortOrder = entity.sortOrder;
}
