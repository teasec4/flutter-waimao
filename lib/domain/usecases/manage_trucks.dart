import 'package:uuid/uuid.dart';

import '../entities/truck.dart';
import '../repositories/truck_repository.dart';

const _uuid = Uuid();

class ManageTrucks {
  final TruckRepository repository;

  ManageTrucks(this.repository);

  Future<List<Truck>> getAll() => repository.getAll();

  Future<void> addTruck(
    String name,
    double length,
    double width,
    double height,
    double maxLoad,
  ) {
    return repository.addTruck(
      Truck(
        id: _uuid.v4(),
        name: name,
        bodyLength: length,
        bodyWidth: width,
        bodyHeight: height,
        maxLoad: maxLoad,
      ),
    );
  }

  Future<void> removeTruck(String id) => repository.removeTruck(id);

  Future<void> updateTruck(Truck truck) => repository.updateTruck(truck);

  /// Стандартные морские контейнеры
  static const Map<String, Map<String, double>> containerPresets = {
    '20ft': {
      'length': 589.8, // 5.898m × 2.352m × 2.393m
      'width': 235.2,
      'height': 239.3,
      'maxLoad': 28230, // кг
    },
    '40ft': {
      'length': 1203.2, // 12.032m × 2.352m × 2.393m
      'width': 235.2,
      'height': 239.3,
      'maxLoad': 28780, // кг
    },
  };

  Future<void> addContainerTemplate(String type) async {
    final preset = containerPresets[type];
    if (preset == null) return;
    final name = type == '20ft' ? '20ft контейнер' : '40ft контейнер';
    await addTruck(
      name,
      preset['length']!,
      preset['width']!,
      preset['height']!,
      preset['maxLoad']!,
    );
  }
}
