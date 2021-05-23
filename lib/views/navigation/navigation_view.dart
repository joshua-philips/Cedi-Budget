import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/views/my_account/my_account_view.dart';
import 'package:groceries_budget_app/views/new_budget/new_budget_date_view.dart';
import 'package:groceries_budget_app/widgets/custom_navigation_bar.dart';
import 'package:groceries_budget_app/widgets/rounded_button.dart';
import 'package:provider/provider.dart';
import 'package:groceries_budget_app/services/auth_service.dart';
import 'budget_history_view.dart';
import 'home_view.dart';
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
                      '${context.watch<AuthService>().getCurrentUser().displayName ?? ''}',
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
                        physics: BouncingScrollPhysics(),
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
                                  await context.read<AuthService>().signOut();
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
        heroTag: 'float',
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
      bottomNavigationBar: CustomBottomNavigationBar(
        backgroundColor: Theme.of(context).cardColor,
        currentIndex: _currentNavigationIndex,
        itemColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        children: [
          CustomBottomNavigationBarItem(
            icon: Icons.home,
            label: 'Home',
            color: Theme.of(context).iconTheme.color,
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.history,
            label: 'Past Budgets',
            color: Theme.of(context).iconTheme.color,
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.settings,
            label: 'Settings',
            color: Theme.of(context).iconTheme.color,
          ),
        ],
        onChange: (index) {
          setState(() {
            _currentNavigationIndex = index;
          });
        },
      ),
      body: _children[_currentNavigationIndex],
    );
  }
}
