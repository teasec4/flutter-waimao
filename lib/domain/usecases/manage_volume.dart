import 'package:uuid/uuid.dart';

import '../entities/volume_item.dart';
import '../repositories/volume_repository.dart';

const _uuid = Uuid();

class ManageVolume {
  final VolumeRepository repository;

  ManageVolume(this.repository);

  Future<List<VolumeItem>> getItems() => repository.getItems();

  Future<void> addItem(
    double length,
    double width,
    double height,
    double weight,
    int quantity,
  ) {
    return repository.addItem(
      VolumeItem(
        id: _uuid.v4(),
        length: length,
        width: width,
        height: height,
        weight: weight,
        quantity: quantity,
      ),
    );
  }

  Future<void> removeItem(String id) => repository.removeItem(id);

  Future<void> clearAll() => repository.clearAll();

  Future<double> calculateTotalVolume() => repository.calculateTotalVolume();

  Future<double> calculateTotalWeight() => repository.calculateTotalWeight();
}
