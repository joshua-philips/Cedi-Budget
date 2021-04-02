import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartCard extends StatelessWidget {
  final Budget budget;

  const PieChartCard({Key key, @required this.budget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, double> dataMap = {
      'Spent': budget.amountUsed,
      'Saved': budget.amountSaved,
      'Balance': budget.amount - budget.amountUsed - budget.amountSaved,
    };
    List<Color> colorList = [
      // Theme.of(context).accentColor,
      Colors.pink[600],
      Colors.green,
      Colors.deepPurple,
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: PieChart(
          dataMap: dataMap,
          colorList: colorList,
          chartType: ChartType.ring,
          ringStrokeWidth: 30,
          chartRadius: MediaQuery.of(context).size.width * 0.4,
          legendOptions: LegendOptions(
            legendTextStyle: TextStyle(fontSize: 20),
          ),
          chartValuesOptions: ChartValuesOptions(
            decimalPlaces: 2,
            showChartValueBackground: false,
            chartValueStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyText2.color,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
