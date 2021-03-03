import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoneyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String helperText;
  final bool autofocus;

  MoneyTextField(
      {Key key, @required this.controller, this.helperText, this.autofocus})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        bottom: 15,
        right: 30,
        left: 30,
      ),
      child: TextField(
        controller: controller,
        maxLines: 1,
        decoration: InputDecoration(
          prefix: Text('GH¢'),
          helperText: helperText,
          labelText: 'Price',
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        textInputAction: TextInputAction.next,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        autofocus: autofocus != null ? autofocus : false,
      ),
    );
  }
}
