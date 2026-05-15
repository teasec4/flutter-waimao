import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/presentation/providers/volume_provider.dart';

/// Диалог добавления новой машины.
class AddTruckDialog extends StatefulWidget {
  const AddTruckDialog({super.key});

  @override
  State<AddTruckDialog> createState() => _AddTruckDialogState();
}

class _AddTruckDialogState extends State<AddTruckDialog> {
  final _nameCtrl = TextEditingController();
  final _lenCtrl = TextEditingController();
  final _widCtrl = TextEditingController();
  final _heiCtrl = TextEditingController();
  final _loadCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _lenCtrl.dispose();
    _widCtrl.dispose();
    _heiCtrl.dispose();
    _loadCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _nameCtrl.text.trim();
    final l = double.tryParse(_lenCtrl.text) ?? 0;
    final w = double.tryParse(_widCtrl.text) ?? 0;
    final h = double.tryParse(_heiCtrl.text) ?? 0;
    final load = double.tryParse(_loadCtrl.text) ?? 0;
    if (name.isNotEmpty && l > 0 && w > 0 && h > 0 && load > 0) {
      context.read<VolumeProvider>().addTruck(name, l, w, h, load);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Новая машина'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameCtrl,
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
                    controller: _lenCtrl,
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
                    controller: _widCtrl,
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
                    controller: _heiCtrl,
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
              controller: _loadCtrl,
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
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Добавить')),
      ],
    );
  }
}
