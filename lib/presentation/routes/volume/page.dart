import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/presentation/providers/volume_provider.dart';
import 'package:paste_tool/presentation/routes/volume/widgets/truck_selector.dart';
import 'package:paste_tool/presentation/routes/volume/widgets/fill_indicator.dart';
import 'package:paste_tool/presentation/routes/volume/widgets/input_fields.dart';
import 'package:paste_tool/presentation/routes/volume/widgets/summary_card.dart';
import 'package:paste_tool/presentation/routes/volume/widgets/item_card.dart';

class VolumePage extends StatefulWidget {
  const VolumePage({super.key});

  @override
  State<VolumePage> createState() => _VolumePageState();
}

class _VolumePageState extends State<VolumePage> {
  final _lengthCtrl = TextEditingController();
  final _widthCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController();

  // Поля для добавления машины
  final _truckNameCtrl = TextEditingController();
  final _truckLenCtrl = TextEditingController();
  final _truckWidCtrl = TextEditingController();
  final _truckHeiCtrl = TextEditingController();
  final _truckLoadCtrl = TextEditingController();

  @override
  void dispose() {
    _lengthCtrl.dispose();
    _widthCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _qtyCtrl.dispose();
    _truckNameCtrl.dispose();
    _truckLenCtrl.dispose();
    _truckWidCtrl.dispose();
    _truckHeiCtrl.dispose();
    _truckLoadCtrl.dispose();
    super.dispose();
  }

  void _addItem() {
    final l = double.tryParse(_lengthCtrl.text) ?? 0;
    final w = double.tryParse(_widthCtrl.text) ?? 0;
    final h = double.tryParse(_heightCtrl.text) ?? 0;
    final kg = double.tryParse(_weightCtrl.text) ?? 0;
    final q = int.tryParse(_qtyCtrl.text) ?? 1;

    if (l > 0 && w > 0 && h > 0) {
      context.read<VolumeProvider>().addItem(l, w, h, kg, q);
      _lengthCtrl.clear();
      _widthCtrl.clear();
      _heightCtrl.clear();
      _weightCtrl.clear();
      _qtyCtrl.clear();
    }
  }

  void _clearAll() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Очистить всё?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () {
              context.read<VolumeProvider>().clearAll();
              Navigator.pop(ctx);
            },
            child: const Text('Очистить'),
          ),
        ],
      ),
    );
  }

  void _showAddTruckDialog() {
    _truckNameCtrl.clear();
    _truckLenCtrl.clear();
    _truckWidCtrl.clear();
    _truckHeiCtrl.clear();
    _truckLoadCtrl.clear();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Новая машина'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _truckNameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Название',
                  hintText: 'ГАЗель Next',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _truckLenCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Длина, см',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _truckWidCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Ширина, см',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _truckHeiCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Высота, см',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _truckLoadCtrl,
                decoration: const InputDecoration(
                  labelText: 'Грузоподъёмность, кг',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          FilledButton(
            onPressed: () {
              final name = _truckNameCtrl.text.trim();
              final l = double.tryParse(_truckLenCtrl.text) ?? 0;
              final w = double.tryParse(_truckWidCtrl.text) ?? 0;
              final h = double.tryParse(_truckHeiCtrl.text) ?? 0;
              final load = double.tryParse(_truckLoadCtrl.text) ?? 0;
              if (name.isNotEmpty && l > 0 && w > 0 && h > 0 && load > 0) {
                context.read<VolumeProvider>().addTruck(name, l, w, h, load);
                Navigator.pop(ctx);
              }
            },
            child: const Text('Добавить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;

        return Consumer<VolumeProvider>(
          builder: (context, provider, _) {
            final truck = provider.activeTruck;

            return Column(
              children: [
                TruckSelector(
                  trucks: provider.trucks,
                  activeTruck: truck,
                  onTruckChanged: (t) => provider.selectTruck(t),
                  onAddTruck: _showAddTruckDialog,
                  onAddContainer20ft: () => provider.addContainerTemplate('20ft'),
                  onAddContainer40ft: () => provider.addContainerTemplate('40ft'),
                ),
                if (truck != null)
                  FillIndicator(
                    bodyDimensions:
                        '${truck.bodyLength.toInt()}×${truck.bodyWidth.toInt()}×${truck.bodyHeight.toInt()} см',
                    bodyVolume: truck.bodyVolume,
                    maxLoad: truck.maxLoad,
                    totalVolume: provider.totalVolume,
                    totalWeight: provider.totalWeight,
                    volumeFillRatio: provider.volumeFillRatio,
                    weightFillRatio: provider.weightFillRatio,
                    canRemove: provider.trucks.length > 1,
                    onRemove: () => provider.removeTruck(truck.id),
                  ),
                const Divider(height: 1),
                if (!isWide) ...[
                  InputFields(
                    lengthCtrl: _lengthCtrl,
                    widthCtrl: _widthCtrl,
                    heightCtrl: _heightCtrl,
                    weightCtrl: _weightCtrl,
                    qtyCtrl: _qtyCtrl,
                    onAdd: _addItem,
                  ),
                  SummaryCard(
                    totalVolume: provider.totalVolume,
                    totalWeight: provider.totalWeight,
                  ),
                ],
                Expanded(child: _buildItemList(isWide, provider)),
                if (isWide) ...[
                  const Divider(height: 1),
                  Row(
                    children: [
                      Expanded(
                        child: InputFields(
                          lengthCtrl: _lengthCtrl,
                          widthCtrl: _widthCtrl,
                          heightCtrl: _heightCtrl,
                          weightCtrl: _weightCtrl,
                          qtyCtrl: _qtyCtrl,
                          onAdd: _addItem,
                        ),
                      ),
                      const VerticalDivider(width: 1),
                      Expanded(
                        child: SummaryCard(
                          totalVolume: provider.totalVolume,
                          totalWeight: provider.totalWeight,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildItemList(bool isWide, VolumeProvider provider) {
    final items = provider.items;
    if (items.isEmpty) {
      return const Center(
        child: Text('Добавьте товары',
            style: TextStyle(color: Colors.grey, fontSize: 16)),
      );
    }
    return Stack(
      children: [
        if (isWide)
          GridView.builder(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 72),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 8,
              childAspectRatio: 3.5,
            ),
            itemCount: items.length,
            itemBuilder: (_, i) => ItemCard(
              item: items[i],
              onDelete: () => provider.removeItem(items[i].id),
            ),
          )
        else
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 72),
            itemCount: items.length,
            itemBuilder: (_, i) => ItemCard(
              item: items[i],
              onDelete: () => provider.removeItem(items[i].id),
            ),
          ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            mini: true,
            onPressed: _clearAll,
            tooltip: 'Очистить всё',
            child: const Icon(Icons.delete_sweep),
          ),
        ),
      ],
    );
  }
}
