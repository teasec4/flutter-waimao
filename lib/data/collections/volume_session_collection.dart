import 'package:isar_community/isar.dart';
import 'package:paste_tool/domain/entities/volume_session.dart';

part 'volume_session_collection.g.dart';

@collection
class VolumeSessionCollection {
  Id id = Isar.autoIncrement;

  @Index()
  late String uuid;

  late String name;
  late String truckId;
  late String truckName;
  late double truckLength;
  late double truckWidth;
  late double truckHeight;
  late double truckMaxLoad;

  /// Список товаров в JSON
  late String itemsJson;

  late String createdAt; // ISO 8601
  late String updatedAt; // ISO 8601

  VolumeSession toEntity() => VolumeSession(
        id: uuid,
        name: name,
        truckId: truckId,
        truckName: truckName,
        truckLength: truckLength,
        truckWidth: truckWidth,
        truckHeight: truckHeight,
        truckMaxLoad: truckMaxLoad,
        items: VolumeSession.itemsFromJson(itemsJson),
        createdAt: DateTime.parse(createdAt),
        updatedAt: DateTime.parse(updatedAt),
      );

  static VolumeSessionCollection fromEntity(VolumeSession entity) =>
      VolumeSessionCollection()
        ..uuid = entity.id
        ..name = entity.name
        ..truckId = entity.truckId
        ..truckName = entity.truckName
        ..truckLength = entity.truckLength
        ..truckWidth = entity.truckWidth
        ..truckHeight = entity.truckHeight
        ..truckMaxLoad = entity.truckMaxLoad
        ..itemsJson = entity.itemsJson
        ..createdAt = entity.createdAt.toIso8601String()
        ..updatedAt = entity.updatedAt.toIso8601String();
}
