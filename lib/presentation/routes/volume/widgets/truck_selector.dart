import 'package:flutter/material.dart';
import 'package:paste_tool/domain/entities/truck.dart';

/// Выпадающий список для выбора машины + кнопки добавления и шаблонов.
class TruckSelector extends StatelessWidget {
  final List<Truck> trucks;
  final Truck? activeTruck;
  final ValueChanged<Truck?> onTruckChanged;
  final VoidCallback onAddTruck;
  final VoidCallback? onAddContainer20ft;
  final VoidCallback? onAddContainer40ft;

  const TruckSelector({
    super.key,
    required this.trucks,
    required this.activeTruck,
    required this.onTruckChanged,
    required this.onAddTruck,
    this.onAddContainer20ft,
    this.onAddContainer40ft,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        border: Border(
          bottom: BorderSide(color: theme.dividerColor),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.local_shipping,
                  color: theme.colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Truck>(
                    isExpanded: true,
                    value: activeTruck,
                    hint: const Text('Выберите машину',
                        style: TextStyle(fontSize: 14)),
                    items: [
                      const DropdownMenuItem<Truck>(
                        value: null,
                        child: Text('Без машины',
                            style: TextStyle(fontSize: 14)),
                      ),
                      ...trucks.map(
                        (t) => DropdownMenuItem(
                          value: t,
                          child:
                              Text(t.name, style: const TextStyle(fontSize: 14)),
                        ),
                      ),
                    ],
                    onChanged: onTruckChanged,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, size: 20),
                tooltip: 'Добавить машину',
                onPressed: onAddTruck,
              ),
            ],
          ),
          // Быстрые шаблоны контейнеров
          if (onAddContainer20ft != null || onAddContainer40ft != null)
            Padding(
              padding: const EdgeInsets.only(left: 28, bottom: 4),
              child: Row(
                children: [
                  Text('Шаблоны: ',
                      style: TextStyle(
                          fontSize: 12, color: theme.colorScheme.onSurfaceVariant)),
                  const SizedBox(width: 4),
                  if (onAddContainer20ft != null)
                    _buildPresetButton(
                      context,
                      icon: Icons.inventory_2_outlined,
                      label: '20ft',
                      tooltip: '20ft контейнер (5.9×2.35×2.39 м)',
                      onPressed: onAddContainer20ft!,
                    ),
                  const SizedBox(width: 4),
                  if (onAddContainer40ft != null)
                    _buildPresetButton(
                      context,
                      icon: Icons.inventory_2_outlined,
                      label: '40ft',
                      tooltip: '40ft контейнер (12.0×2.35×2.39 м)',
                      onPressed: onAddContainer40ft!,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPresetButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 12, color: Theme.of(context).colorScheme.primary)),
          ],
        ),
      ),
    );
  }
}
