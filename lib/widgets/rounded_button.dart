import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final Widget child;
  final VoidCallback onPressed;

  RoundedButton({
    @required this.color,
    @required this.child,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
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
}
