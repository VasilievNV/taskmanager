import 'package:flutter/material.dart';
import 'package:taskmanager/core/src/colors.dart';

/*class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ;
  }
}*/

class AppLoader {
  static void show(BuildContext context) {
    showGeneralDialog(
      fullscreenDialog: true,
      context: context, 
      barrierColor: Colors.transparent,
      pageBuilder: (context, animate1, animate2) {
        return Scaffold(
          backgroundColor: Colors.white.withValues(alpha: 0.8),
          body: Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: colorButtonPrimaryLight,
            ),
          ),
        );
      }
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}

