import 'package:flutter/material.dart';
import 'package:groceries_budget_app/services/auth_service.dart';

class MyProvider extends InheritedWidget {
  final AuthService auth;

  MyProvider({Key key, Widget child, this.auth})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static MyProvider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<MyProvider>());
}
