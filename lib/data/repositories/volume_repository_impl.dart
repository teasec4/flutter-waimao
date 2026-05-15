import 'package:isar_community/isar.dart';
import 'package:paste_tool/data/collections/volume_item_collection.dart';
import 'package:paste_tool/domain/entities/volume_item.dart';
import 'package:paste_tool/domain/repositories/volume_repository.dart';

class VolumeRepositoryImpl implements VolumeRepository {
  final Isar isar;

  VolumeRepositoryImpl({required this.isar});

  @override
  Future<List<VolumeItem>> getItems() async {
    return isar.volumeItemCollections.where().findAll().then(
      (list) => list.map((c) => c.toEntity()).toList(),
    );
  }

  @override
  Future<void> addItem(VolumeItem item) async {
    final collection = VolumeItemCollection.fromEntity(item);
    await isar.writeTxn(() => isar.volumeItemCollections.put(collection));
  }

  @override
  Future<void> removeItem(String id) async {
    final existing = await isar.volumeItemCollections
        .filter()
        .uuidEqualTo(id)
        .findAll();
    if (existing.isNotEmpty) {
      await isar.writeTxn(
        () => isar.volumeItemCollections.deleteAll(
          existing.map((e) => e.id).toList(),
        ),
      );
    }
  }

  @override
  Future<void> clearAll() async {
    await isar.writeTxn(() => isar.volumeItemCollections.clear());
  }

  @override
  Future<double> calculateTotalVolume() async {
    final items = await getItems();
    return items.fold<double>(0, (sum, item) => sum + item.totalVolume);
  }

  @override
  Future<double> calculateTotalWeight() async {
    final items = await getItems();
    return items.fold<double>(0, (sum, item) => sum + item.totalWeight);
  }
}
