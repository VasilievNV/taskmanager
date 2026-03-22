import 'package:flutter/widgets.dart';

class AppLoaderNotifier extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setState(bool state) {
    if (_isLoading == state) return;

    _isLoading = state;

    if (_isLoading) {
      FocusManager.instance.primaryFocus?.unfocus();
    }

    notifyListeners();
  }
}