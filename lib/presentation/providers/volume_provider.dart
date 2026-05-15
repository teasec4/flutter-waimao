import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import 'package:paste_tool/domain/entities/truck.dart';
import 'package:paste_tool/domain/entities/volume_item.dart';
import 'package:paste_tool/domain/entities/volume_session.dart';
import 'package:paste_tool/domain/usecases/manage_sessions.dart';
import 'package:paste_tool/domain/usecases/manage_trucks.dart';
import 'package:paste_tool/domain/usecases/manage_volume.dart';

const _uuid = Uuid();

enum VolumeScreen { start, input }

/// Состояния сессии на экране input.
enum InputMode { newSession, editing }

class VolumeProvider extends ChangeNotifier {
  final ManageVolume _manageVolume;
  final ManageTrucks _manageTrucks;
  final ManageSessions _manageSessions;

  // --- Кэшированные данные ---

  List<VolumeItem> _items = [];
  List<VolumeItem> get items => _items;

  double _totalVolume = 0;
  double get totalVolume => _totalVolume;

  double _totalWeight = 0;
  double get totalWeight => _totalWeight;

  Future<void> _refreshVolumeData() async {
    _items = await _manageVolume.getItems();
    _totalVolume = await _manageVolume.calculateTotalVolume();
    _totalWeight = await _manageVolume.calculateTotalWeight();
    notifyListeners();
  }

  // --- Навигация ---

  VolumeScreen _screen = VolumeScreen.start;
  VolumeScreen get screen => _screen;

  InputMode _inputMode = InputMode.newSession;
  InputMode get inputMode => _inputMode;

  // --- Машины ---

  List<Truck> _trucks = [];
  List<Truck> get trucks => _trucks;

  Truck? _activeTruck;
  Truck? get activeTruck => _activeTruck;

  double get volumeFillRatio {
    if (_activeTruck == null || _activeTruck!.bodyVolume <= 0) return 0;
    return (_totalVolume / _activeTruck!.bodyVolume).clamp(0, 1);
  }

  double get weightFillRatio {
    if (_activeTruck == null || _activeTruck!.maxLoad <= 0) return 0;
    return (_totalWeight / _activeTruck!.maxLoad).clamp(0, 1);
  }

  double get remainingVolume {
    if (_activeTruck == null) return 0;
    return (_activeTruck!.bodyVolume - _totalVolume).clamp(0, double.infinity);
  }

  double get remainingWeight {
    if (_activeTruck == null) return 0;
    return (_activeTruck!.maxLoad - _totalWeight).clamp(0, double.infinity);
  }

  // --- Сохранённые сессии ---

  List<VolumeSession> _sessions = [];
  List<VolumeSession> get sessions => _sessions;

  VolumeProvider(this._manageVolume, this._manageTrucks, this._manageSessions) {
    // fire-and-forget загрузка начальных данных
    _loadTrucks();
    _loadSessions();
  }

  Future<void> _loadTrucks() async {
    _trucks = await _manageTrucks.getAll();
  }

  Future<void> _loadSessions() async {
    _sessions = await _manageSessions.getAll();
  }

  // --- Навигация ---

  Future<void> goToStart() async {
    _activeTruck = null;
    await _manageVolume.clearAll();
    await _loadTrucks();
    await _loadSessions();
    _screen = VolumeScreen.start;
    await _refreshVolumeData();
  }

  Future<void> goToInput({Truck? truck}) async {
    _activeTruck = truck;
    _inputMode = InputMode.newSession;
    await _manageVolume.clearAll();
    _screen = VolumeScreen.input;
    await _refreshVolumeData();
  }

  /// Открыть существующую сессию для просмотра / редактирования.
  Future<void> editSession(VolumeSession session) async {
    // Загружаем данные сессии
    _activeTruck = Truck(
      id: session.truckId,
      name: session.truckName,
      bodyLength: session.truckLength,
      bodyWidth: session.truckWidth,
      bodyHeight: session.truckHeight,
      maxLoad: session.truckMaxLoad,
    );
    await _manageVolume.clearAll();
    for (final item in session.items) {
      await _manageVolume.addItem(
        item.length,
        item.width,
        item.height,
        item.weight,
        item.quantity,
      );
    }
    _inputMode = InputMode.editing;
    _screen = VolumeScreen.input;
    await _refreshVolumeData();
  }

  // --- Управление товарами ---

  Future<void> addItem(
    double length,
    double width,
    double height,
    double weight,
    int quantity,
  ) async {
    await _manageVolume.addItem(length, width, height, weight, quantity);
    await _refreshVolumeData();
  }

  Future<void> removeItem(String id) async {
    await _manageVolume.removeItem(id);
    await _refreshVolumeData();
  }

  Future<void> clearAll() async {
    await _manageVolume.clearAll();
    await _refreshVolumeData();
  }

  // --- Управление машинами ---

  void selectTruck(Truck? truck) {
    _activeTruck = truck;
    notifyListeners();
  }

  Future<void> addTruck(
    String name,
    double length,
    double width,
    double height,
    double maxLoad,
  ) async {
    await _manageTrucks.addTruck(name, length, width, height, maxLoad);
    await _loadTrucks();
    notifyListeners();
  }

  Future<void> addContainerTemplate(String type) async {
    await _manageTrucks.addContainerTemplate(type);
    await _loadTrucks();
    notifyListeners();
  }

  Future<void> removeTruck(String id) async {
    if (_activeTruck?.id == id) {
      _activeTruck = null;
    }
    await _manageTrucks.removeTruck(id);
    await _loadTrucks();
    notifyListeners();
  }

  // --- Управление сессиями ---

  Future<void> saveSession(String name) async {
    if (_activeTruck == null) return;

    final now = DateTime.now();
    final session = VolumeSession(
      id: _uuid.v4(),
      name: name,
      createdAt: now,
      updatedAt: now,
      truckId: _activeTruck!.id,
      truckName: _activeTruck!.name,
      truckLength: _activeTruck!.bodyLength,
      truckWidth: _activeTruck!.bodyWidth,
      truckHeight: _activeTruck!.bodyHeight,
      truckMaxLoad: _activeTruck!.maxLoad,
      items: List.from(_items),
    );
    await _manageSessions.save(session);
    await _loadSessions();
    notifyListeners();
  }

  Future<void> deleteSession(String id) async {
    await _manageSessions.delete(id);
    await _loadSessions();
    notifyListeners();
  }

  Future<void> updateSession(String sessionId) async {
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
      items: List.from(_items),
    );
    await _manageSessions.update(session);
    await _loadSessions();
    notifyListeners();
  }
}
