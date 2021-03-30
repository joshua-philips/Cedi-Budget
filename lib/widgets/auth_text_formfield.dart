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
        style: TextStyle(color: Colors.black),
        cursorColor: Colors.redAccent,
        autofocus: autofocus != null ? autofocus : false,
        obscureText: obscureText != null ? obscureText : false,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          focusColor: Colors.white,
          hintText: hintText ?? '',
          hintStyle: TextStyle(color: Colors.black),
          errorStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.all(8),
        ),
        validator: validator,
      ),
    );
  }
}

class UpdateTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String helperText;
  final String label;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final bool autofocus;

  UpdateTextFormField({
    @required this.controller,
    this.validator,
    this.helperText,
    this.obscureText,
    this.autofocus,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        controller: controller,
        cursorColor: Colors.redAccent,
        autofocus: autofocus != null ? autofocus : false,
        obscureText: obscureText != null ? obscureText : false,
        decoration: InputDecoration(
          helperText: helperText ?? '',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
