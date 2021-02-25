import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String> validator;

  AuthTextFormField({
    @required this.controller,
    this.validator,
    this.hintText,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.black,
        obscureText: obscureText != null ? obscureText : false,
        decoration: InputDecoration(
          hintText: hintText ?? '',
          hintStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(color: Colors.black),
        ),
        validator: validator,
      ),
    );
  }
}
