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
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          helperText: helperText,
          helperStyle: TextStyle(color: Colors.black),
          hintText: 'Item',
          hintStyle: TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding: EdgeInsets.all(8),
        ),
        autofocus: autofocus != null ? autofocus : false,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.sentences,
      ),
    );
  }
}
