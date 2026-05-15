import '../entities/truck.dart';

abstract class TruckRepository {
  Future<List<Truck>> getAll();
  Future<void> addTruck(Truck truck);
  Future<void> removeTruck(String id);
  Future<void> updateTruck(Truck truck);
}
