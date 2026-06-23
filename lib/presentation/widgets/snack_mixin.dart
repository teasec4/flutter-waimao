import 'package:flutter/material.dart';

/// Примесь для State-классов: снекбары, undo-снекбары и проверка ошибок.
mixin SnackMixin<T extends StatefulWidget> on State<T> {
  void showSnack(Text content) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: content,
          duration: const Duration(milliseconds: 800),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  void showUndoSnack(String message, VoidCallback onUndo) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'Отмена',
            onPressed: () {
              onUndo();
              showSnack(const Text('Восстановлено'));
            },
          ),
        ),
      );
  }

  /// Проверяет [errorText] и показывает снекбар, если ошибка есть.
  /// Вызывает [onClear] для сброса ошибки.
  void checkError(String? errorText, VoidCallback onClear) {
    if (errorText != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          showSnack(Text(errorText));
          onClear();
        }
      });
    }
  }
}
