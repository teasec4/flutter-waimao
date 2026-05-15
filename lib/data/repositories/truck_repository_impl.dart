import 'package:isar_community/isar.dart';
import 'package:paste_tool/data/collections/truck_collection.dart';
import 'package:paste_tool/domain/entities/truck.dart';
import 'package:paste_tool/domain/repositories/truck_repository.dart';

class TruckRepositoryImpl implements TruckRepository {
  final Isar isar;

  TruckRepositoryImpl({required this.isar});

  @override
  Future<List<Truck>> getAll() async {
    return isar.truckCollections.where().findAll().then(
      (list) => list.map((c) => c.toEntity()).toList(),
    );
  }

  @override
  Future<void> addTruck(Truck truck) async {
    final collection = TruckCollection.fromEntity(truck);
    await isar.writeTxn(() => isar.truckCollections.put(collection));
  }

  @override
  Future<void> removeTruck(String id) async {
    final existing = await isar.truckCollections
        .filter()
        .uuidEqualTo(id)
        .findAll();
    if (existing.isNotEmpty) {
      await isar.writeTxn(
        () =>
            isar.truckCollections.deleteAll(existing.map((e) => e.id).toList()),
      );
    }
  }

  @override
  Future<void> updateTruck(Truck truck) async {
    final existing = await isar.truckCollections
        .filter()
        .uuidEqualTo(truck.id)
        .findAll();
    if (existing.isNotEmpty) {
      final updated = TruckCollection.fromEntity(truck);
      updated.id = existing.first.id;
      await isar.writeTxn(() => isar.truckCollections.put(updated));
    }
  }
}
