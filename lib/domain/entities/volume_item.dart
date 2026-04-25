class VolumeItem {
  final String id;
  final double length;
  final double width;
  final double height;
  final double weight;
  final int quantity;

  const VolumeItem({
    required this.id,
    required this.length,
    required this.width,
    required this.height,
    required this.weight,
    required this.quantity,
  });

  double get volume => length * width * height / 1000000;

  double get totalVolume => volume * quantity;

  double get totalWeight => weight * quantity;
}
