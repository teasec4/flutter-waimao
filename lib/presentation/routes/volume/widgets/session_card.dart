import 'package:flutter/material.dart';

import 'package:paste_tool/domain/entities/volume_session.dart';

class SessionCard extends StatelessWidget {
  final VolumeSession session;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const SessionCard({
    super.key,
    required this.session,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final fillColor = _fillColor(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.assignment, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      session.name,
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18),
                    visualDensity: VisualDensity.compact,
                    onPressed: onDelete,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                '${session.truckName} · ${session.items.length} товаров',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: session.volumeFillRatio > 0 ? session.volumeFillRatio : null,
                  backgroundColor: fillColor.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation(fillColor),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${session.totalVolume.toStringAsFixed(2)} / ${session.bodyVolume.toStringAsFixed(1)} м³',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.grey[500],
                        ),
                  ),
                  Text(
                    '${session.totalWeight.toStringAsFixed(0)} / ${session.truckMaxLoad.toInt()} кг',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.grey[500],
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _fillColor(BuildContext context) {
    final ratio = session.volumeFillRatio;
    if (ratio >= 0.9) return Colors.red;
    if (ratio >= 0.7) return Colors.orange;
    return Theme.of(context).colorScheme.primary;
  }
}
