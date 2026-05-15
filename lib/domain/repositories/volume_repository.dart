import '../entities/volume_item.dart';

abstract class VolumeRepository {
  Future<List<VolumeItem>> getItems();
  Future<void> addItem(VolumeItem item);
  Future<void> removeItem(String id);
  Future<void> clearAll();
  Future<double> calculateTotalVolume();
  Future<double> calculateTotalWeight();
}
