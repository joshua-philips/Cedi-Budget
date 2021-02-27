import 'package:flutter/material.dart';
import 'package:groceries_budget_app/services/auth_service.dart';

import 'services/database_service.dart';

class MyProvider extends InheritedWidget {
  final AuthService auth;
  final DatabaseService database;

  MyProvider(
      {Key key, Widget child, @required this.auth, @required this.database})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static MyProvider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<MyProvider>());
}
