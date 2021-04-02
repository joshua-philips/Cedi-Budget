import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:percent_indicator/percent_indicator.dart';

class PercentCard extends StatelessWidget {
  final Budget budget;

  const PercentCard({Key key, @required this.budget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final progressColor = Theme.of(context).accentColor;
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 15,
          left: 8,
          right: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Total Used: GH¢${(budget.amountSaved + budget.amountUsed).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
            LinearPercentIndicator(
              lineHeight: 30,
              progressColor: progressColor,
              percent: calculatePercent(
                  (budget.amountSaved + budget.amountUsed), budget.amount),
              padding: EdgeInsets.symmetric(horizontal: 20),
              center: Text(
                '${(calculatePercent((budget.amountSaved + budget.amountUsed), budget.amount) * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(thickness: 1.5),
            Text('Total Used Breakdown'),
            Text(
              'Spent: GH¢${(budget.amountUsed).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
            LinearPercentIndicator(
              lineHeight: 30,
              progressColor: progressColor,
              percent: calculatePercent(budget.amountUsed, budget.amount),
              padding: EdgeInsets.symmetric(horizontal: 20),
              center: Text(
                '${(calculatePercent(budget.amountUsed, budget.amount) * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Saved: GH¢${(budget.amountSaved).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
            ),
            LinearPercentIndicator(
              lineHeight: 30,
              progressColor: progressColor,
              percent: calculatePercent(budget.amountSaved, budget.amount),
              padding: EdgeInsets.symmetric(horizontal: 20),
              center: Text(
                '${(calculatePercent(budget.amountSaved, budget.amount) * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculatePercent(double number, double total) {
    return number / total;
  }
}
