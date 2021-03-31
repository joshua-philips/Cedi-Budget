import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void showLoadingSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(days: 1),
      content: Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: SpinKitWave(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.transparent,
    ),
  );
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SpinKitWave(
        color: Colors.white,
      ),
    ),
  );
}

void hideLoadingDialog(BuildContext context) {
  Navigator.of(context).pop();
}

void showMessageSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
