import 'package:flutter/material.dart';

ElevatedButton roundedButton(
    {@required Color color,
    @required Widget child,
    @required VoidCallback onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      primary: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    child: child,
    onPressed: onPressed,
  );
}
