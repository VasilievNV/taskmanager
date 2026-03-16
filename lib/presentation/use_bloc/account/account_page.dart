import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/presentation/use_provider/theme_mode/notifier/theme_mode_notifier.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeModeNotifier>();

    return Scaffold(
      backgroundColor: theme.state.colorBackgroundPrimary,
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: Center(
        child: Text("Account"),
      ),
    );
  }
}