import 'package:flutter/widgets.dart';
import 'package:taskmanager/presentation/use_provider/navigation_bar/state/navigation_bar_state.dart';

class NavigationBarNotifier extends ChangeNotifier {
  NavigationBarState _state = NavigationBarState(index: 0);

  NavigationBarState get state => _state;

  void setState(int index) {
    _state = NavigationBarState(index: index);
    notifyListeners();
  }
}