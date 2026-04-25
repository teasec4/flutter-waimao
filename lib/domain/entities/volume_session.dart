import 'dart:convert';

import 'volume_item.dart';

/// Сессия расчёта загрузки — грузовик + список товаров.
///
/// Данные грузовика копируются при сохранении, чтобы изменения
/// в справочнике машин не ломали старые расчёты.
class VolumeSession {
  final String id;
  final String name;
  final String truckId;

  // Скопированные данные грузовика на момент сохранения
  final String truckName;
  final double truckLength; // см
  final double truckWidth; // см
  final double truckHeight; // см
  final double truckMaxLoad; // кг

  final List<VolumeItem> items;
  final DateTime createdAt;
  final DateTime updatedAt;

  const VolumeSession({
    required this.id,
    required this.name,
    required this.truckId,
    required this.truckName,
    required this.truckLength,
    required this.truckWidth,
    required this.truckHeight,
    required this.truckMaxLoad,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Объём кузова в м³
  double get bodyVolume =>
      truckLength * truckWidth * truckHeight / 1000000;

  /// Суммарный объём товаров в м³
  double get totalVolume =>
      items.fold<double>(0, (sum, item) => sum + item.totalVolume);

  /// Суммарный вес товаров в кг
  double get totalWeight =>
      items.fold<double>(0, (sum, item) => sum + item.totalWeight);

  /// Заполнение по объёму (0.0–1.0)
  double get volumeFillRatio {
    if (bodyVolume <= 0) return 0;
    return (totalVolume / bodyVolume).clamp(0, 1);
  }

  /// Заполнение по весу (0.0–1.0)
  double get weightFillRatio {
    if (truckMaxLoad <= 0) return 0;
    return (totalWeight / truckMaxLoad).clamp(0, 1);
  }

  /// Сериализация товаров в JSON для Isar
  String get itemsJson =>
      jsonEncode(items.map((i) => i.toJson()).toList());

  /// Десериализация товаров из JSON
  static List<VolumeItem> itemsFromJson(String json) {
    final list = jsonDecode(json) as List;
    return list.map((e) => VolumeItem.fromJson(e as Map<String, dynamic>)).toList();
  }
}
