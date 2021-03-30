import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';

class TotalBudgetCard extends StatelessWidget {
  final Budget budget;

  const TotalBudgetCard({Key key, @required this.budget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).brightness != Brightness.dark
          ? Theme.of(context).accentColor
          : Theme.of(context).cardColor,
      child: ListTile(
        title: Text(
          'Total:',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          'GH¢' + budget.amount.toStringAsFixed(0),
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
