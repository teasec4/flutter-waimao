import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

class SettingsProvider extends ChangeNotifier {
  final SharedPreferences _prefs;

  ThemeMode _themeMode = ThemeMode.light;
  bool _alwaysOnTop = false;

  SettingsProvider({required SharedPreferences prefs}) : _prefs = prefs;

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

  void saveLastTab(int index) {
    _prefs.setInt('last_tab_index', index);
  }
}
