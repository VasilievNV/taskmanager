import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/use_provider/theme_mode/notifier/theme_mode_notifier.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeModeNotifier>();
    return Scaffold(
      backgroundColor: theme.state.colorBackgroundPrimary,
      appBar: AppBar(
        title: Text("Chats"),
      ),
      body: Center(
        child: Text("Chats"),
      ),
    );
  }
}