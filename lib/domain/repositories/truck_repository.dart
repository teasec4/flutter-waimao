import '../entities/truck.dart';

abstract class TruckRepository {
  List<Truck> getAll();
  void addTruck(Truck truck);
  void removeTruck(String id);
  void updateTruck(Truck truck);
}
