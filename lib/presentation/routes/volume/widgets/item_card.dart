import 'package:flutter/material.dart';
import 'package:paste_tool/domain/entities/volume_item.dart';

/// Карточка одного товара в списке груза.
class ItemCard extends StatelessWidget {
  final VolumeItem item;
  final VoidCallback onDelete;

  const ItemCard({
    super.key,
    required this.item,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final dims = '${item.length.toInt()} × ${item.width.toInt()} × ${item.height.toInt()} см'
        ' × ${item.quantity} шт';
    final stats = '${_fmt(item.totalWeight)} кг  ·  ${_fmt(item.totalVolume)} м³';

    return Card(
      margin: const EdgeInsets.only(bottom: 4),
      child: ListTile(
        title: Text(dims),
        subtitle: Text(stats),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }

  String _fmt(double v) => v.toStringAsFixed(v.abs() >= 100 ? 1 : 3);
}
