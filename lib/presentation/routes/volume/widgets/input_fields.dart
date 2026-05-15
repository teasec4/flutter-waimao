import 'package:flutter/material.dart';

/// Поля ввода: длина, ширина, высота, вес, количество + кнопка «Добавить».
class InputFields extends StatelessWidget {
  final TextEditingController lengthCtrl;
  final TextEditingController widthCtrl;
  final TextEditingController heightCtrl;
  final TextEditingController weightCtrl;
  final TextEditingController qtyCtrl;
  final VoidCallback onAdd;

  const InputFields({
    super.key,
    required this.lengthCtrl,
    required this.widthCtrl,
    required this.heightCtrl,
    required this.weightCtrl,
    required this.qtyCtrl,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 480;

          if (isCompact) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(child: _numberField(lengthCtrl, 'Длина, см')),
                    const SizedBox(width: 8),
                    Expanded(child: _numberField(widthCtrl, 'Ширина, см')),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _numberField(heightCtrl, 'Высота, см')),
                    const SizedBox(width: 8),
                    Expanded(child: _numberField(weightCtrl, 'Вес, кг')),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(child: _numberField(qtyCtrl, 'Кол-во')),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: onAdd,
                        icon: const Icon(Icons.add),
                        label: const Text('Добавить'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(child: _numberField(lengthCtrl, 'Длина, см')),
                  const SizedBox(width: 8),
                  Expanded(child: _numberField(widthCtrl, 'Ширина, см')),
                  const SizedBox(width: 8),
                  Expanded(child: _numberField(heightCtrl, 'Высота, см')),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _numberField(weightCtrl, 'Вес, кг')),
                  const SizedBox(width: 8),
                  Expanded(child: _numberField(qtyCtrl, 'Кол-во')),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: onAdd,
                    icon: const Icon(Icons.add),
                    label: const Text('Добавить'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
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
