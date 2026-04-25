import 'package:paste_tool/domain/entities/truck.dart';
import 'package:paste_tool/domain/repositories/truck_repository.dart';

class ManageTrucks {
  final TruckRepository repository;

  ManageTrucks(this.repository);

  List<Truck> getAll() => repository.getAll();

  void addTruck(String name, double length, double width, double height, double maxLoad) {
    repository.addTruck(
      Truck(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        bodyLength: length,
        bodyWidth: width,
        bodyHeight: height,
        maxLoad: maxLoad,
      ),
    );
  }

  void removeTruck(String id) => repository.removeTruck(id);

  void updateTruck(Truck truck) => repository.updateTruck(truck);

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

  void addContainerTemplate(String type) {
    final preset = containerPresets[type];
    if (preset == null) return;
    final name = type == '20ft' ? '20ft контейнер' : '40ft контейнер';
    addTruck(name, preset['length']!, preset['width']!, preset['height']!,
        preset['maxLoad']!);
  }
}
