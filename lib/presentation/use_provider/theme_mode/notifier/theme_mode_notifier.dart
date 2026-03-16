import 'package:flutter/widgets.dart';
import 'package:taskmanager/core/utils/enums.dart';
import 'package:taskmanager/presentation/use_provider/theme_mode/state/theme_mode_state.dart';

class ThemeModeNotifier extends ChangeNotifier {
  ThemeModeState _state = ThemeModeState(ETheme.light);

  ThemeModeState get state => _state;

  void setState(ETheme theme) {
    _state = ThemeModeState(theme);
    notifyListeners();
  }
}