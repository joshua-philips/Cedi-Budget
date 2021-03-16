import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final bool autofocus;

  AuthTextFormField({
    @required this.controller,
    this.validator,
    this.hintText,
    this.obscureText,
    this.autofocus,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.redAccent,
        autofocus: autofocus != null ? autofocus : false,
        obscureText: obscureText != null ? obscureText : false,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: hintText ?? '',
          hintStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(color: Colors.black),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
              width: 2,
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
