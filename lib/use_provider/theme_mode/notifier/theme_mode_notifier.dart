import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/core/utils/enums.dart';
import 'package:taskmanager/use_provider/theme_mode/state/theme_mode_state.dart';

class ThemeModeNotifier extends ChangeNotifier {
  ThemeModeState _state = ThemeModeState(ETheme.light);

  ThemeModeState get state => _state;

  void setState(ETheme theme) {
    _state = ThemeModeState(theme);
    notifyListeners();
  }
}

/*class ThemeModeNotifier extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; // По умолчанию системная
  ThemeMode get themeMode => _themeMode;

  // Ключ для хранения в настройках
  static const _themeKey = 'user_theme_mode';

  ThemeModeNotifier() {
    _loadTheme();
  }

  void setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();

    // Сохраняем выбор
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode.index);
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIndex = prefs.getInt(_themeKey);
    if (savedIndex != null) {
      _themeMode = ThemeMode.values[savedIndex];
      notifyListeners();
    }
  }
}*/