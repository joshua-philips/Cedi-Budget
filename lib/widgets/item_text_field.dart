import 'package:flutter/material.dart';

class ItemTextField extends StatelessWidget {
  final TextEditingController controller;
  final String helperText;
  final bool autofocus;

  ItemTextField(
      {Key key, @required this.controller, this.helperText, this.autofocus})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
        bottom: 10,
      ),
      child: TextField(
        controller: controller,
        maxLines: 1,
        decoration: InputDecoration(
          prefix: Text('Item: '),
          helperText: helperText,
          labelText: 'Item',
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
              width: 2,
            ),
          ),
        ),
        autofocus: autofocus != null ? autofocus : false,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.sentences,
      ),
    );
  }
}
