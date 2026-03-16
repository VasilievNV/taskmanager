import 'package:flutter/material.dart';

class AppNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onSelected;
  final Color? backgroundColor;

  const AppNavigationBar({
    required this.selectedIndex,
    required this.onSelected,
    this.backgroundColor,

    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NavigationBar(
        selectedIndex: selectedIndex,
        //backgroundColor: Colors.white,
        onDestinationSelected: onSelected,
        backgroundColor: backgroundColor,
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_box),
            label: 'Account',
          ),
        ]
      ),
    );
  }
}