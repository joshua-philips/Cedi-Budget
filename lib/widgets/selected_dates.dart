import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:intl/intl.dart';

Widget buildSelectedDates(BuildContext context, Budget budget) {
  Color dateColor = Theme.of(context).textTheme.bodyText2.color;
  return Padding(
    padding: EdgeInsets.only(top: 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              'Start Date',
              style: TextStyle(color: dateColor),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${DateFormat('EEE, dd/MM').format(budget.startDate).toString()}',
                style: TextStyle(fontSize: 25, color: dateColor),
              ),
            ),
            Text(
              '${DateFormat('yyyy').format(budget.startDate).toString()}',
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.bold, color: dateColor),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 15),
          child: Icon(
            Icons.arrow_forward,
            size: 30,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.green[800]
                : Theme.of(context).accentColor,
          ),
        ),
        Column(
          children: [
            Text(
              'End Date',
              style: TextStyle(color: dateColor),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${DateFormat('EEE, dd/MM').format(budget.endDate).toString()}',
                style: TextStyle(fontSize: 25, color: dateColor),
              ),
            ),
            Text(
              '${DateFormat('yyyy').format(budget.endDate).toString()}',
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.bold, color: dateColor),
            ),
          ],
        ),
      ],
    ),
  );
}
