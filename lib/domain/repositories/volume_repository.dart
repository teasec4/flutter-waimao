import '../entities/volume_item.dart';

abstract class VolumeRepository {
  List<VolumeItem> getItems();
  void addItem(VolumeItem item);
  void removeItem(String id);
  void clearAll();
  double get totalVolume;
  double get totalWeight;
}
