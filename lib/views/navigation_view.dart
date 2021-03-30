import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/my_provider.dart';
import 'package:groceries_budget_app/views/my_account/my_account_view.dart';
import 'package:groceries_budget_app/widgets/rounded_button.dart';
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
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: [
                    Icon(Icons.account_circle),
                    SizedBox(width: 5),
                    Text(
                      '${MyProvider.of(context).auth.getCurrentUser().displayName ?? ''}',
                      style: TextStyle(
                        color: Theme.of(context)
                            .appBarTheme
                            .textTheme
                            .headline6
                            .color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  context: context,
                  builder: (context) => Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedButton(
                              color: Colors.green[900],
                              child: Text(
                                'Account Info',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Route route = MaterialPageRoute(
                                    builder: (context) => MyAccountView());
                                Navigator.of(context).pop();
                                Navigator.push(context, route);
                              },
                            ),
                            RoundedButton(
                              color: Theme.of(context).accentColor,
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () async {
                                try {
                                  await MyProvider.of(context).auth.signOut();
                                } catch (e) {
                                  print(e);
                                }
                                Navigator.of(context).pop();
                              },
                            ),
                            SizedBox(height: 5),
                            Divider(thickness: 1.5),
                            SizedBox(height: 5),
                            RoundedButton(
                              color: Colors.deepPurple,
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: Icon(Icons.add),
        onPressed: () {
          Route route = MaterialPageRoute(
            builder: (context) => NewBudgetDateView(
              budget: budget,
            ),
          );
          Navigator.push(context, route);
        },
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
