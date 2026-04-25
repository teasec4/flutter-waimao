import 'package:flutter/foundation.dart';
import 'package:paste_tool/domain/entities/truck.dart';
import 'package:paste_tool/domain/entities/volume_item.dart';
import 'package:paste_tool/domain/usecases/manage_trucks.dart';
import 'package:paste_tool/domain/usecases/manage_volume.dart';

class VolumeProvider extends ChangeNotifier {
  final ManageVolume _manageVolume;
  final ManageTrucks _manageTrucks;

  List<VolumeItem> get items => _manageVolume.getItems();
  double get totalVolume => _manageVolume.totalVolume;
  double get totalWeight => _manageVolume.totalWeight;

  List<Truck> _trucks = [];
  List<Truck> get trucks => _trucks;

  Truck? _activeTruck;
  Truck? get activeTruck => _activeTruck;

  /// Заполнение кузова по объёму (0.0 — 1.0)
  double get volumeFillRatio {
    if (_activeTruck == null || _activeTruck!.bodyVolume <= 0) return 0;
    return (totalVolume / _activeTruck!.bodyVolume).clamp(0, 1);
  }

  /// Заполнение кузова по весу (0.0 — 1.0)
  double get weightFillRatio {
    if (_activeTruck == null || _activeTruck!.maxLoad <= 0) return 0;
    return (totalWeight / _activeTruck!.maxLoad).clamp(0, 1);
  }

  /// Осталось объёма в м³
  double get remainingVolume {
    if (_activeTruck == null) return 0;
    return (_activeTruck!.bodyVolume - totalVolume).clamp(0, double.infinity);
  }

  /// Осталось грузоподъёмности в кг
  double get remainingWeight {
    if (_activeTruck == null) return 0;
    return (_activeTruck!.maxLoad - totalWeight).clamp(0, double.infinity);
  }

  VolumeProvider(this._manageVolume, this._manageTrucks) {
    _loadTrucks();
  }

  void _loadTrucks() {
    _trucks = _manageTrucks.getAll();
    notifyListeners();
  }

  // --- Управление товарами ---

  void addItem(
      double length, double width, double height, double weight, int quantity) {
    _manageVolume.addItem(length, width, height, weight, quantity);
    notifyListeners();
  }

  void removeItem(String id) {
    _manageVolume.removeItem(id);
    notifyListeners();
  }

  void clearAll() {
    _manageVolume.clearAll();
    notifyListeners();
  }

  // --- Управление машинами ---

  void selectTruck(Truck? truck) {
    _activeTruck = truck;
    notifyListeners();
  }

  void addTruck(
      String name, double length, double width, double height, double maxLoad) {
    _manageTrucks.addTruck(name, length, width, height, maxLoad);
    _loadTrucks();
  }

  void addContainerTemplate(String type) {
    _manageTrucks.addContainerTemplate(type);
    _loadTrucks();
  }

  void removeTruck(String id) {
    if (_activeTruck?.id == id) {
      _activeTruck = null;
    }
    _manageTrucks.removeTruck(id);
    _loadTrucks();
  }
}
