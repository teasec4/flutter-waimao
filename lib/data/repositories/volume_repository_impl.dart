import 'package:isar_community/isar.dart';
import 'package:paste_tool/data/collections/volume_item_collection.dart';
import 'package:paste_tool/domain/entities/volume_item.dart';
import 'package:paste_tool/domain/repositories/volume_repository.dart';

class VolumeRepositoryImpl implements VolumeRepository {
  final Isar isar;

  VolumeRepositoryImpl({required this.isar});

  @override
  List<VolumeItem> getItems() {
    return isar.volumeItemCollections
        .where()
        .findAllSync()
        .map((c) => c.toEntity())
        .toList();
  }

  @override
  void addItem(VolumeItem item) {
    final collection = VolumeItemCollection.fromEntity(item);
    isar.writeTxnSync(() => isar.volumeItemCollections.putSync(collection));
  }

  @override
  void removeItem(String id) {
    final existing = isar.volumeItemCollections
        .filter()
        .uuidEqualTo(id)
        .findAllSync();
    if (existing.isNotEmpty) {
      isar.writeTxnSync(
        () => isar.volumeItemCollections.deleteAllSync(
          existing.map((e) => e.id).toList(),
        ),
      );
    }
  }

  @override
  void clearAll() {
    isar.writeTxnSync(() => isar.volumeItemCollections.clearSync());
  }

  @override
  double get totalVolume {
    final items = getItems();
    return items.fold<double>(0, (sum, item) => sum + item.totalVolume);
  }

  @override
  double get totalWeight {
    final items = getItems();
    return items.fold<double>(0, (sum, item) => sum + item.totalWeight);
  }
}
