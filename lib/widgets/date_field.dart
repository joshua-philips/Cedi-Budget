import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateField extends StatelessWidget {
  final String label;
  final DateTime date;
  final IconData icon;
  final Function onIconPressed;

  const DateField({
    Key key,
    this.label,
    this.date,
    this.icon,
    this.onIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Text(label),
            ],
          ),
          Row(
            children: [
              Text(
                DateFormat('MMM dd, yyyy').format(date).toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Spacer(),
              InkWell(
                child: Icon(icon, size: 40),
                onTap: onIconPressed,
              ),
            ],
          ),
          Divider(thickness: 2),
        ],
      ),
    );
  }
}
