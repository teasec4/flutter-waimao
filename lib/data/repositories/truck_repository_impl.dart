import 'package:isar_community/isar.dart';
import 'package:paste_tool/data/collections/truck_collection.dart';
import 'package:paste_tool/domain/entities/truck.dart';
import 'package:paste_tool/domain/repositories/truck_repository.dart';

class TruckRepositoryImpl implements TruckRepository {
  final Isar isar;

  TruckRepositoryImpl({required this.isar});

  @override
  List<Truck> getAll() {
    return isar.truckCollections
        .where()
        .findAllSync()
        .map((c) => c.toEntity())
        .toList();
  }

  @override
  void addTruck(Truck truck) {
    final collection = TruckCollection.fromEntity(truck);
    isar.writeTxnSync(() => isar.truckCollections.putSync(collection));
  }

  @override
  void removeTruck(String id) {
    final existing = isar.truckCollections
        .filter()
        .uuidEqualTo(id)
        .findAllSync();
    if (existing.isNotEmpty) {
      isar.writeTxnSync(
        () => isar.truckCollections
            .deleteAllSync(existing.map((e) => e.id).toList()),
      );
    }
  }

  @override
  void updateTruck(Truck truck) {
    final existing = isar.truckCollections
        .filter()
        .uuidEqualTo(truck.id)
        .findAllSync();
    if (existing.isNotEmpty) {
      final updated = TruckCollection.fromEntity(truck);
      updated.id = existing.first.id;
      isar.writeTxnSync(() => isar.truckCollections.putSync(updated));
    }
  }
}
