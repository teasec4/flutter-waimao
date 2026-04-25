import 'package:paste_tool/domain/entities/volume_item.dart';
import 'package:paste_tool/domain/repositories/volume_repository.dart';

class ManageVolume {
  final VolumeRepository repository;

  ManageVolume(this.repository);

  List<VolumeItem> getItems() => repository.getItems();

  void addItem(
    double length,
    double width,
    double height,
    double weight,
    int quantity,
  ) {
    repository.addItem(
      VolumeItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        length: length,
        width: width,
        height: height,
        weight: weight,
        quantity: quantity,
      ),
    );
  }

  void removeItem(String id) => repository.removeItem(id);

  void clearAll() => repository.clearAll();

  double get totalVolume => repository.totalVolume;

  double get totalWeight => repository.totalWeight;
}
