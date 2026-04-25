import 'package:flutter/foundation.dart';
import 'package:paste_tool/domain/entities/truck.dart';
import 'package:paste_tool/domain/entities/volume_item.dart';
import 'package:paste_tool/domain/entities/volume_session.dart';
import 'package:paste_tool/domain/usecases/manage_sessions.dart';
import 'package:paste_tool/domain/usecases/manage_trucks.dart';
import 'package:paste_tool/domain/usecases/manage_volume.dart';

enum VolumeScreen { start, input }

/// Состояния сессии на экране input.
enum InputMode { newSession, editing }

class VolumeProvider extends ChangeNotifier {
  final ManageVolume _manageVolume;
  final ManageTrucks _manageTrucks;
  final ManageSessions _manageSessions;

  // --- Навигация ---

  VolumeScreen _screen = VolumeScreen.start;
  VolumeScreen get screen => _screen;

  InputMode _inputMode = InputMode.newSession;
  InputMode get inputMode => _inputMode;

  // --- Данные текущего расчёта (input screen) ---

  List<VolumeItem> get items => _manageVolume.getItems();
  double get totalVolume => _manageVolume.totalVolume;
  double get totalWeight => _manageVolume.totalWeight;

  List<Truck> _trucks = [];
  List<Truck> get trucks => _trucks;

  Truck? _activeTruck;
  Truck? get activeTruck => _activeTruck;

  double get volumeFillRatio {
    if (_activeTruck == null || _activeTruck!.bodyVolume <= 0) return 0;
    return (totalVolume / _activeTruck!.bodyVolume).clamp(0, 1);
  }

  double get weightFillRatio {
    if (_activeTruck == null || _activeTruck!.maxLoad <= 0) return 0;
    return (totalWeight / _activeTruck!.maxLoad).clamp(0, 1);
  }

  double get remainingVolume {
    if (_activeTruck == null) return 0;
    return (_activeTruck!.bodyVolume - totalVolume).clamp(0, double.infinity);
  }

  double get remainingWeight {
    if (_activeTruck == null) return 0;
    return (_activeTruck!.maxLoad - totalWeight).clamp(0, double.infinity);
  }

  // --- Сохранённые сессии ---

  List<VolumeSession> _sessions = [];
  List<VolumeSession> get sessions => _sessions;

  VolumeProvider(
    this._manageVolume,
    this._manageTrucks,
    this._manageSessions,
  ) {
    _loadTrucks();
    _loadSessions();
  }

  void _loadTrucks() {
    _trucks = _manageTrucks.getAll();
  }

  void _loadSessions() {
    _sessions = _manageSessions.getAll();
  }

  // --- Навигация ---

  void goToStart() {
    _activeTruck = null;
    _manageVolume.clearAll();
    _loadTrucks();
    _loadSessions();
    _screen = VolumeScreen.start;
    notifyListeners();
  }

  void goToInput({Truck? truck}) {
    _activeTruck = truck;
    _inputMode = InputMode.newSession;
    _manageVolume.clearAll();
    _screen = VolumeScreen.input;
    notifyListeners();
  }

  /// Открыть существующую сессию для просмотра / редактирования.
  void editSession(VolumeSession session) {
    // Загружаем данные сессии
    _activeTruck = Truck(
      id: session.truckId,
      name: session.truckName,
      bodyLength: session.truckLength,
      bodyWidth: session.truckWidth,
      bodyHeight: session.truckHeight,
      maxLoad: session.truckMaxLoad,
    );
    _manageVolume.clearAll();
    for (final item in session.items) {
      _manageVolume.addItem(
        item.length,
        item.width,
        item.height,
        item.weight,
        item.quantity,
      );
    }
    _inputMode = InputMode.editing;
    _screen = VolumeScreen.input;
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
    notifyListeners();
  }

  void addContainerTemplate(String type) {
    _manageTrucks.addContainerTemplate(type);
    _loadTrucks();
    notifyListeners();
  }

  void removeTruck(String id) {
    if (_activeTruck?.id == id) {
      _activeTruck = null;
    }
    _manageTrucks.removeTruck(id);
    _loadTrucks();
    notifyListeners();
  }

  // --- Управление сессиями ---

  void saveSession(String name) {
    if (_activeTruck == null) return;

    final now = DateTime.now();
    final session = VolumeSession(
      id: now.millisecondsSinceEpoch.toString(),
      name: name,
      createdAt: now,
      updatedAt: now,
      truckId: _activeTruck!.id,
      truckName: _activeTruck!.name,
      truckLength: _activeTruck!.bodyLength,
      truckWidth: _activeTruck!.bodyWidth,
      truckHeight: _activeTruck!.bodyHeight,
      truckMaxLoad: _activeTruck!.maxLoad,
      items: List.from(items),
    );
    _manageSessions.save(session);
    _loadSessions();
    notifyListeners();
  }

  void deleteSession(String id) {
    _manageSessions.delete(id);
    _loadSessions();
    notifyListeners();
  }

  void updateSession(String sessionId) {
    if (_activeTruck == null) return;

    final session = VolumeSession(
      id: sessionId,
      name: '', // имя не меняем
      createdAt: DateTime.now(), // будет перезаписано из старой записи
      updatedAt: DateTime.now(),
      truckId: _activeTruck!.id,
      truckName: _activeTruck!.name,
      truckLength: _activeTruck!.bodyLength,
      truckWidth: _activeTruck!.bodyWidth,
      truckHeight: _activeTruck!.bodyHeight,
      truckMaxLoad: _activeTruck!.maxLoad,
      items: List.from(items),
    );
    _manageSessions.update(session);
    _loadSessions();
    notifyListeners();
  }
}
