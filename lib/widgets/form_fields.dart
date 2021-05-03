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
            borderRadius: BorderRadius.circular(5),
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
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        validator: validator,
      ),
    );
  }
}


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
        bottom: 10,
        left: 50,
      ),
      child: TextField(
        controller: controller,
        maxLines: 1,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefix: Text('GH¢'),
          prefixStyle: TextStyle(color: Colors.black),
          helperText: helperText,
          hintText: '0.00',
          hintStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding: EdgeInsets.all(8),
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        textInputAction: TextInputAction.next,
        autofocus: autofocus != null ? autofocus : false,
      ),
    );
  }
}

