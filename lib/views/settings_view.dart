import 'package:flutter/material.dart';
import 'package:groceries_budget_app/services/auth_service.dart';
import 'package:groceries_budget_app/services/theme_provider.dart';
import 'package:groceries_budget_app/views/about_view.dart';
import 'package:groceries_budget_app/views/help_and_feedback_view.dart';
import 'package:provider/provider.dart';
import 'package:groceries_budget_app/my_provider.dart';
import 'my_account/my_account_view.dart';

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
    AuthService auth = MyProvider.of(context).auth;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ThemeNotifier>(
              builder: (context, notifier, child) => Card(
                child: ListTile(
                  leading: notifier.darkTheme
                      ? Icon(Icons.wb_sunny)
                      : Icon(Icons.nights_stay),
                  subtitle: Text('App will reload'),
                  title: Text(
                    '${notifier.darkTheme ? 'Switch to light mode' : 'Switch to dark mode'}',
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
                onTap: () {
                  Route route =
                      MaterialPageRoute(builder: (context) => MyAccountView());
                  Navigator.of(context).push(route);
                },
                child: ListTile(
                  title: Text('My account'),
                  subtitle: Text('${auth.getCurrentUser().email}'),
                  leading: Icon(Icons.account_circle),
                ),
              ),
            ),
            Card(
              child: InkWell(
                onTap: () {
                  Route route = MaterialPageRoute(
                    builder: (context) => HelpAndFeedback(),
                  );
                  Navigator.of(context).push(route);
                },
                child: ListTile(
                  title: Text('Help & Feedback'),
                  subtitle: Text(''),
                  leading: Icon(Icons.help),
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
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: TextButton(
                  style: TextButton.styleFrom(

                  padding: EdgeInsets.only(left: 8),
                  minimumSize: Size(0,0),
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue,),
                  ),
                  
                  onPressed: () async {
                    try {
                      await auth.signOut();
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
