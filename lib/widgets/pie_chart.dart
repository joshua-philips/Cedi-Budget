import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
// import 'package:pie_chart/pie_chart.dart';

// class PieChartCard extends StatelessWidget {
//   final Budget budget;

//   const PieChartCard({Key key, @required this.budget}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Map<String, double> dataMap = {
//       'Spent': budget.amountUsed,
//       'Saved': budget.amountSaved,
//       'Balance': budget.amount - budget.amountUsed - budget.amountSaved,
//     };
//     List<Color> colorList = [
//       // Theme.of(context).accentColor,
//       Colors.pink[600],
//       Colors.green,
//       Colors.deepPurple,
//     ];
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: PieChart(
//           dataMap: dataMap,
//           colorList: colorList,
//           chartType: ChartType.ring,
//           ringStrokeWidth: 30,
//           chartRadius: MediaQuery.of(context).size.width * 0.4,
//           legendOptions: LegendOptions(
//             legendTextStyle: TextStyle(fontSize: 20),
//           ),
//           chartValuesOptions: ChartValuesOptions(
//             decimalPlaces: 2,
//             showChartValueBackground: false,
//             chartValueStyle: TextStyle(
//               color: Theme.of(context).textTheme.bodyText2.color,
//               fontWeight: FontWeight.bold,
//               fontSize: 15,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class PieChartCardFL extends StatefulWidget {
  final Budget budget;

  const PieChartCardFL({Key key, @required this.budget}) : super(key: key);
  @override
  _PieChartCardFLState createState() => _PieChartCardFLState();
}

class _PieChartCardFLState extends State<PieChartCardFL> {
  int touchedIndex;
  Map<String, double> dataMap;

  @override
  void initState() {
    super.initState();
    dataMap = {
      'Spent': widget.budget.amountUsed,
      'Saved': widget.budget.amountSaved,
      'Balance': widget.budget.amount -
          widget.budget.amountUsed -
          widget.budget.amountSaved,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 40,
                  sections: getSections(),
                ),
              ),
            ),
            SizedBox(width: 10),
            buildIndicators(),
          ],
        ),
      ),
    );
  }

  Widget buildIndicators() {
    double size = 16;
    List<Color> colors = [Colors.pink[600], Colors.green, Colors.deepPurple];
    List<String> indicatorText = ['Spent', 'Saved', 'Balance'];
    List<Widget> indicators = [];
    for (int count = 0; count < 3; count++) {
      indicators.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors[count],
              ),
            ),
            SizedBox(width: 10),
            Text(indicatorText[count]),
          ],
        ),
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }

  List<PieChartSectionData> getSections() {
    return [
      PieChartSectionData(
        color: Colors.pink[600],
        title: '${dataMap.values.elementAt(0).toStringAsFixed(2)}',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.green,
        title: '${dataMap.values.elementAt(1).toStringAsFixed(2)}',
        radius: 50,
      ),
      PieChartSectionData(
        color: Colors.deepPurple,
        title: '${dataMap.values.elementAt(2).toStringAsFixed(2)}',
        radius: 50,
      ),
    ];
  }
}
