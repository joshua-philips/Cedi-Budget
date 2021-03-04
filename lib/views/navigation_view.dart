import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'budget_history_view.dart';
import 'home_view.dart';
import 'new_budget/new_budget_date_view.dart';
import 'settings_view.dart';

class NavigationView extends StatefulWidget {
  @override
  _NavigationViewState createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  final Budget budget = Budget.noArgument();
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
        title: Text('Cedi Budget'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              tooltip: 'Add New Budget',
              icon: Icon(Icons.add),
              onPressed: () {
                Route route = MaterialPageRoute(
                  builder: (context) => NewBudgetDateView(
                    budget: budget,
                  ),
                );
                Navigator.push(context, route);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).accentColor,
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
