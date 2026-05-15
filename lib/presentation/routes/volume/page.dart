import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/presentation/providers/volume_provider.dart';
import 'package:paste_tool/presentation/routes/volume/widgets/truck_selector.dart';
import 'package:paste_tool/presentation/routes/volume/widgets/fill_indicator.dart';
import 'package:paste_tool/presentation/routes/volume/widgets/input_fields.dart';
import 'package:paste_tool/presentation/routes/volume/widgets/summary_card.dart';
import 'package:paste_tool/presentation/routes/volume/widgets/item_card.dart';
import 'package:paste_tool/presentation/routes/volume/widgets/add_truck_dialog.dart';
import 'package:paste_tool/presentation/routes/volume/widgets/save_session_dialog.dart';
import 'package:paste_tool/presentation/routes/volume/widgets/start_screen.dart';

class VolumePage extends StatefulWidget {
  const VolumePage({super.key});

  @override
  State<VolumePage> createState() => _VolumePageState();
}

class _VolumePageState extends State<VolumePage> {
  final _lenCtrl = TextEditingController();
  final _widCtrl = TextEditingController();
  final _heiCtrl = TextEditingController();
  final _weiCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController();

  @override
  void dispose() {
    _lenCtrl.dispose();
    _widCtrl.dispose();
    _heiCtrl.dispose();
    _weiCtrl.dispose();
    _qtyCtrl.dispose();
    super.dispose();
  }

  void _addItem() {
    final l = double.tryParse(_lenCtrl.text) ?? 0;
    final w = double.tryParse(_widCtrl.text) ?? 0;
    final h = double.tryParse(_heiCtrl.text) ?? 0;
    final kg = double.tryParse(_weiCtrl.text) ?? 0;
    final q = int.tryParse(_qtyCtrl.text) ?? 1;

    if (l > 0 && w > 0 && h > 0) {
      context.read<VolumeProvider>().addItem(l, w, h, kg, q);
      _lenCtrl.clear();
      _widCtrl.clear();
      _heiCtrl.clear();
      _weiCtrl.clear();
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
    showDialog(context: context, builder: (_) => const AddTruckDialog());
  }

  void _showSaveDialog() {
    showDialog(context: context, builder: (_) => const SaveSessionDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VolumeProvider>(
      builder: (context, provider, _) {
        switch (provider.screen) {
          case VolumeScreen.start:
            return StartScreen(
              trucks: provider.trucks,
              sessions: provider.sessions,
              onNewCalculation: (truck) => provider.goToInput(truck: truck),
              onEditSession: (session) => provider.editSession(session),
              onDeleteSession: (id) => provider.deleteSession(id),
              onAddTruck: _showAddTruckDialog,
              onAddContainer20ft: () => provider.addContainerTemplate('20ft'),
              onAddContainer40ft: () => provider.addContainerTemplate('40ft'),
            );
          case VolumeScreen.input:
            return _buildInputScreen(provider);
        }
      },
    );
  }

  Widget _buildInputScreen(VolumeProvider provider) {
    final truck = provider.activeTruck;
    final isWide = MediaQuery.of(context).size.width > 600;

    return Column(
      children: [
        _buildTopBar(provider),
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
        if (!isWide)
          Column(
            children: [
              InputFields(
                lengthCtrl: _lenCtrl,
                widthCtrl: _widCtrl,
                heightCtrl: _heiCtrl,
                weightCtrl: _weiCtrl,
                qtyCtrl: _qtyCtrl,
                onAdd: _addItem,
              ),
              SummaryCard(
                totalVolume: provider.totalVolume,
                totalWeight: provider.totalWeight,
              ),
            ],
          ),
        Expanded(child: _buildItemList(isWide, provider)),
        if (isWide)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: InputFields(
                    lengthCtrl: _lenCtrl,
                    widthCtrl: _widCtrl,
                    heightCtrl: _heiCtrl,
                    weightCtrl: _weiCtrl,
                    qtyCtrl: _qtyCtrl,
                    onAdd: _addItem,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SummaryCard(
                    totalVolume: provider.totalVolume,
                    totalWeight: provider.totalWeight,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTopBar(VolumeProvider provider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Назад',
            onPressed: () => provider.goToStart(),
          ),
          const Spacer(),
          Text(
            provider.inputMode == InputMode.editing
                ? 'Редактирование'
                : 'Новый расчёт',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.save_outlined),
            tooltip: 'Сохранить',
            onPressed: _showSaveDialog,
          ),
        ],
      ),
    );
  }

  Widget _buildItemList(bool isWide, VolumeProvider provider) {
    final items = provider.items;
    if (items.isEmpty) {
      return const Center(
        child: Text(
          'Добавьте товары',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
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
