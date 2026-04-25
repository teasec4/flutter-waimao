import 'package:flutter/material.dart';

import 'package:paste_tool/domain/entities/truck.dart';
import 'package:paste_tool/domain/entities/volume_session.dart';
import 'package:paste_tool/presentation/routes/volume/widgets/session_card.dart';

class StartScreen extends StatelessWidget {
  final List<Truck> trucks;
  final List<VolumeSession> sessions;
  final void Function(Truck truck) onNewCalculation;
  final void Function(VolumeSession session) onEditSession;
  final void Function(String id) onDeleteSession;
  final VoidCallback onAddTruck;
  final VoidCallback onAddContainer20ft;
  final VoidCallback onAddContainer40ft;

  const StartScreen({
    super.key,
    required this.trucks,
    required this.sessions,
    required this.onNewCalculation,
    required this.onEditSession,
    required this.onDeleteSession,
    required this.onAddTruck,
    required this.onAddContainer20ft,
    required this.onAddContainer40ft,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // --- Сохранённые расчёты ---
        if (sessions.isNotEmpty) ...[
          Text('Сохранённые расчёты',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...sessions.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SessionCard(
                session: s,
                onTap: () => onEditSession(s),
                onDelete: () => onDeleteSession(s.id),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // --- Новый расчёт ---
        Text('Новый расчёт',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),

        // Быстрый старт с шаблоном
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Начните с контейнера',
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.inventory_2_outlined),
                        label: const Text('20 ft'),
                        onPressed: onAddContainer20ft,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.inventory_2_outlined),
                        label: const Text('40 ft'),
                        onPressed: onAddContainer40ft,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Своя машина'),
                    onPressed: onAddTruck,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // --- Выбор из сохранённых машин ---
        if (trucks.isNotEmpty) ...[
          Text('Мои машины',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...trucks.map(
            (t) => _TruckCard(
              truck: t,
              onTap: () => onNewCalculation(t),
            ),
          ),
        ] else ...[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'Добавьте машину или используйте шаблон контейнера',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _TruckCard extends StatelessWidget {
  final Truck truck;
  final VoidCallback onTap;

  const _TruckCard({required this.truck, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.local_shipping_outlined),
        title: Text(truck.name),
        subtitle: Text(
          '${truck.bodyLength.toInt()}×${truck.bodyWidth.toInt()}×${truck.bodyHeight.toInt()} см · '
          '${truck.bodyVolume.toStringAsFixed(1)} м³ · ${truck.maxLoad.toInt()} кг',
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
