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

  Map<String, dynamic> toJson() => {
    'id': id,
    'length': length,
    'width': width,
    'height': height,
    'weight': weight,
    'quantity': quantity,
  };

  factory VolumeItem.fromJson(Map<String, dynamic> json) => VolumeItem(
    id: json['id'] as String,
    length: (json['length'] as num).toDouble(),
    width: (json['width'] as num).toDouble(),
    height: (json['height'] as num).toDouble(),
    weight: (json['weight'] as num).toDouble(),
    quantity: (json['quantity'] as int),
  );
}
