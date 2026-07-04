import 'package:flutter/material.dart';

/// Mixin for State classes: snackbars, undo snackbars, and error checking.
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
            label: 'Undo',
            onPressed: () {
              onUndo();
              showSnack(const Text('Restored'));
            },
          ),
        ),
      );
  }

  /// Checks [errorText] and shows a snackbar if an error is present.
  /// Calls [onClear] to reset the error.
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
