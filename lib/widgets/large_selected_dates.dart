import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:intl/intl.dart';

Widget buildSelectedDatesLarge({BuildContext context, Budget budget}) {
  return Padding(
    padding: EdgeInsets.only(top: 15),
    child: Column(
      children: [
        Column(
          children: [
            Text(
              'Start Date',
              style: TextStyle(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${DateFormat('EEE, dd/MM').format(budget.startDate).toString()}',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              '${DateFormat('yyyy').format(budget.startDate).toString()}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: Icon(
            Icons.arrow_downward,
            size: 45,
            color: Colors.white,
          ),
        ),
        Column(
          children: [
            Text(
              'End Date',
              style: TextStyle(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${DateFormat('EEE, dd/MM').format(budget.endDate).toString()}',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              '${DateFormat('yyyy').format(budget.endDate).toString()}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
