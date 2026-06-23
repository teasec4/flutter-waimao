import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  bool _alwaysOnTop = false;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get alwaysOnTop => _alwaysOnTop;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }

  Future<void> toggleAlwaysOnTop() async {
    _alwaysOnTop = !_alwaysOnTop;
    notifyListeners();
    await windowManager.setAlwaysOnTop(_alwaysOnTop);
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}
