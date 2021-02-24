import 'package:flutter/material.dart';
import 'package:groceries_budget_app/services/theme_provider.dart';
import 'package:groceries_budget_app/views/about_view.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<ThemeNotifier>(
            builder: (context, notifier, child) => Card(
              child: ListTile(
                leading: notifier.darkTheme
                    ? Icon(Icons.wb_sunny)
                    : Icon(Icons.nights_stay),
                title: Text(
                  '${notifier.darkTheme ? 'Switch to Light Mode' : 'Switch to Dark Mode'}',
                ),
                trailing: Switch(
                  value: notifier.darkTheme,
                  activeColor: Theme.of(context).accentColor,
                  onChanged: (value) {
                    notifier.toggleTheme();
                  },
                ),
              ),
            ),
          ),
          Card(
            child: InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My Account'),
                // TODO: Get email from firebase
                subtitle: Text('philipsjoshua96@gmail.com'),
                leading: Icon(Icons.account_circle),
              ),
            ),
          ),
          Card(
            child: InkWell(
              onTap: () {
                Route route = MaterialPageRoute(
                  builder: (context) => AboutView(),
                );
                Navigator.of(context).push(route);
              },
              child: ListTile(
                title: Text('About'),
                subtitle: Text('www.organisationname.com'),
                leading: Icon(Icons.info),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
