import 'package:flutter/material.dart';

/// Return to the home screen no matter where you are in the app
class AppBarHomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.only(right: 10),
      icon: Icon(Icons.home),
      onPressed: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
  }
}