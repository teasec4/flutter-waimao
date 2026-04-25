import 'package:isar_community/isar.dart';
import 'package:paste_tool/domain/entities/truck.dart';

part 'truck_collection.g.dart';

@collection
class TruckCollection {
  Id id = Isar.autoIncrement;

  @Index()
  late String uuid;

  late String name;
  late double bodyLength;
  late double bodyWidth;
  late double bodyHeight;
  late double maxLoad;

  Truck toEntity() => Truck(
        id: uuid,
        name: name,
        bodyLength: bodyLength,
        bodyWidth: bodyWidth,
        bodyHeight: bodyHeight,
        maxLoad: maxLoad,
      );

  static TruckCollection fromEntity(Truck entity) => TruckCollection()
    ..uuid = entity.id
    ..name = entity.name
    ..bodyLength = entity.bodyLength
    ..bodyWidth = entity.bodyWidth
    ..bodyHeight = entity.bodyHeight
    ..maxLoad = entity.maxLoad;
}
