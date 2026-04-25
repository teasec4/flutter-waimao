import 'package:flutter/material.dart';

/// Краткая сводка: общий объём и общий вес.
class SummaryCard extends StatelessWidget {
  final double totalVolume;
  final double totalWeight;

  const SummaryCard({
    super.key,
    required this.totalVolume,
    required this.totalWeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _item(theme, Icons.inventory_2, 'Объём', '${_fmt(totalVolume)} м³'),
              Container(width: 1, height: 32, color: theme.dividerColor),
              _item(theme, Icons.fitness_center, 'Вес', '${_fmt(totalWeight)} кг'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(ThemeData theme, IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.primary),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        Text(label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            )),
      ],
    );
  }

  String _fmt(double v) => v.toStringAsFixed(v.abs() >= 100 ? 1 : 3);
}
