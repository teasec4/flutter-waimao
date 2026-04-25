import 'package:flutter/material.dart';

/// Индикатор заполнения кузова (объём + вес) с прогресс-барами.
class FillIndicator extends StatelessWidget {
  final String bodyDimensions;
  final double bodyVolume;
  final double maxLoad;
  final double totalVolume;
  final double totalWeight;
  final double volumeFillRatio;
  final double weightFillRatio;
  final bool canRemove;
  final VoidCallback? onRemove;

  const FillIndicator({
    super.key,
    required this.bodyDimensions,
    required this.bodyVolume,
    required this.maxLoad,
    required this.totalVolume,
    required this.totalWeight,
    required this.volumeFillRatio,
    required this.weightFillRatio,
    required this.canRemove,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      color: theme.colorScheme.surfaceContainerLow,
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.straighten, size: 16, color: theme.colorScheme.primary),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Кузов: $bodyDimensions  ·  ${_fmt(bodyVolume)} м³  ·  до ${maxLoad.toInt()} кг',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              if (canRemove)
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 16),
                  tooltip: 'Удалить машину',
                  visualDensity: VisualDensity.compact,
                  onPressed: onRemove,
                ),
            ],
          ),
          const SizedBox(height: 8),
          _buildProgressBar(
            theme,
            Icons.inventory_2,
            'Объём',
            totalVolume,
            bodyVolume,
            volumeFillRatio,
          ),
          const SizedBox(height: 4),
          _buildProgressBar(
            theme,
            Icons.fitness_center,
            'Вес',
            totalWeight,
            maxLoad,
            weightFillRatio,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(ThemeData theme, IconData icon, String label,
      double current, double max, double ratio) {
    final exceeded = ratio >= 1;
    final color = exceeded ? theme.colorScheme.error : theme.colorScheme.primary;

    return Row(
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 6),
        SizedBox(
          width: 40,
          child: Text(label,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: ratio.clamp(0, 1),
                  minHeight: 10,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation(color),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${_fmt(current)} / ${_fmt(max)} ${label == 'Объём' ? 'м³' : 'кг'}'
                '${exceeded ? ' ⚠️ Превышение!' : ' — ${(ratio * 100).toInt()}%'}',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _fmt(double v) => v.toStringAsFixed(v.abs() >= 100 ? 1 : 3);
}
