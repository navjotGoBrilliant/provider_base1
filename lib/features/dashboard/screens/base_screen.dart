import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_base1/features/dashboard/screens/request_screen.dart';
import 'package:provider_base1/features/dashboard/screens/settings_screen.dart';
import '../provider/bottom_navigation_provider.dart';
import 'home_screen.dart';

class BaseScreen extends StatelessWidget {
  final List<Widget> _screens = [
    HomeScreen(),
    RequestScreen(),
    SettingsScreen(),
  ];

  BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<BottomNavigationProvider>(context);

    return Scaffold(
      body: _screens[navigationProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationProvider.currentIndex,
        onTap: (index) {
          navigationProvider.changeIndex(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),

            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Request',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}