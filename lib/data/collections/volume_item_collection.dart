import 'package:isar_community/isar.dart';
import 'package:paste_tool/domain/entities/volume_item.dart';

part 'volume_item_collection.g.dart';

@collection
class VolumeItemCollection {
  Id id = Isar.autoIncrement;

  @Index()
  late String uuid;

  late double length;
  late double width;
  late double height;
  late double weight;
  late int quantity;

  VolumeItem toEntity() => VolumeItem(
    id: uuid,
    length: length,
    width: width,
    height: height,
    weight: weight,
    quantity: quantity,
  );

  static VolumeItemCollection fromEntity(VolumeItem entity) =>
      VolumeItemCollection()
        ..uuid = entity.id
        ..length = entity.length
        ..width = entity.width
        ..height = entity.height
        ..weight = entity.weight
        ..quantity = entity.quantity;
}
