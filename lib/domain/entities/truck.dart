class Truck {
  final String id;
  final String name;
  final double bodyLength; // см
  final double bodyWidth; // см
  final double bodyHeight; // см
  final double maxLoad; // кг

  const Truck({
    required this.id,
    required this.name,
    required this.bodyLength,
    required this.bodyWidth,
    required this.bodyHeight,
    required this.maxLoad,
  });

  /// Объём кузова в м³
  double get bodyVolume => bodyLength * bodyWidth * bodyHeight / 1000000;
}
