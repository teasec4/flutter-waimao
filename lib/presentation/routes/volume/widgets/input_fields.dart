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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: lengthCtrl,
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
                  controller: widthCtrl,
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
                  controller: heightCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Высота, см',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: weightCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Вес, кг',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: qtyCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Кол-во',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add),
                label: const Text('Добавить'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
