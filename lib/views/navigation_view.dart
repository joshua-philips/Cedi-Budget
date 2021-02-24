import 'package:flutter/material.dart';
import 'budget_history_view.dart';
import 'home_view.dart';
import 'settings_view.dart';

class NavigationView extends StatefulWidget {
  @override
  _NavigationViewState createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  int _currentNavigationIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    BudgetHistoryView(),
    SettingsView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Groceries Budget'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentNavigationIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Budget History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentNavigationIndex = index;
          });
        },
      ),
      body: _children[_currentNavigationIndex],
    );
  }
}
