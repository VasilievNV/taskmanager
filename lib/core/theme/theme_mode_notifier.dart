import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeModeNotifier extends ChangeNotifier {
  final SharedPreferences _prefs;
  ThemeMode _themeMode;

  static const _themeKey = 'user_theme_mode';

  ThemeModeNotifier(this._prefs) 
      : _themeMode = ThemeMode.values[_prefs.getInt(_themeKey) ?? ThemeMode.system.index];

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
    await _prefs.setInt(_themeKey, mode.index);
  }
}