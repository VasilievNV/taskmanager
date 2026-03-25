import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/core/theme/app_color_theme.dart';
import 'package:taskmanager/core/widgets/app_loader.dart/notifier/app_loader_provider.dart';

class AppLoaderWrapper extends StatelessWidget {
  final Widget? child;
  const AppLoaderWrapper({this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppColorTheme>();

    return Stack(
      children: [
        ?child,
        Consumer<AppLoaderNotifier>(
          builder: (context, loader, _) {
            if (!loader.isLoading) return const SizedBox.shrink();
            return AbsorbPointer(
              absorbing: true, 
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white.withValues(alpha: 0.8),
                body: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: theme?.buttonPrimary,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}