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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isCompact = constraints.maxWidth < 420;

            return Column(
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
                if (isCompact)
                  Column(
                    children: [
                      _numberField(_lenCtrl, 'Длина, см'),
                      const SizedBox(height: 12),
                      _numberField(_widCtrl, 'Ширина, см'),
                      const SizedBox(height: 12),
                      _numberField(_heiCtrl, 'Высота, см'),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(child: _numberField(_lenCtrl, 'Длина, см')),
                      const SizedBox(width: 8),
                      Expanded(child: _numberField(_widCtrl, 'Ширина, см')),
                      const SizedBox(width: 8),
                      Expanded(child: _numberField(_heiCtrl, 'Высота, см')),
                    ],
                  ),
                const SizedBox(height: 12),
                _numberField(_loadCtrl, 'Грузоподъёмность, кг'),
              ],
            );
          },
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

  Widget _numberField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}
