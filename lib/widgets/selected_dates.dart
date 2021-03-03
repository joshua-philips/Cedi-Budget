import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:intl/intl.dart';

Widget buildSelectedDates(BuildContext context, Budget budget) {
  return Padding(
    padding: EdgeInsets.only(top: 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text('Start Date'),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${DateFormat('EEE, dd/MM').format(budget.startDate).toString()}',
                style: TextStyle(fontSize: 25),
              ),
            ),
            Text(
              '${DateFormat('yyyy').format(budget.startDate).toString()}',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 15),
          child: Icon(
            Icons.arrow_forward,
            size: 30,
            color: Theme.of(context).accentColor,
          ),
        ),
        Column(
          children: [
            Text('End Date'),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${DateFormat('EEE, dd/MM').format(budget.endDate).toString()}',
                style: TextStyle(fontSize: 25),
              ),
            ),
            Text(
              '${DateFormat('yyyy').format(budget.endDate).toString()}',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    ),
  );
}
