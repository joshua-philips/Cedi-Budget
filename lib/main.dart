import 'package:flutter/material.dart';
import 'package:groceries_budget_app/services/theme_provider.dart';
import 'package:groceries_budget_app/views/navigation_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
          builder: (context, notifier, child) {
            return MaterialApp(
              title: 'Groceries Budget',
              debugShowCheckedModeBanner: false,
              theme: notifier.darkTheme ? dark : light,
              home: NavigationView(),
            );
          },
        ));
  }
}
