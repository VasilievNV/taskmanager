import 'package:flutter/foundation.dart';

class Console {
  static void log(Object? param) {
    if (kDebugMode) {
      print(param);
    }
  }
}