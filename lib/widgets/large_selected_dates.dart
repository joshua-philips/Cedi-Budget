import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:intl/intl.dart';

class LargeSelectedDates extends StatelessWidget {
  final Budget budget;

  const LargeSelectedDates({Key key, @required this.budget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Column(
            children: [
              Text(
                'Start Date',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '${DateFormat('EEE, dd/MM').format(budget.startDate).toString()}',
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
              Text(
                '${DateFormat('yyyy').format(budget.startDate).toString()}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Icon(
              Icons.arrow_downward,
              size: 45,
            ),
          ),
          Column(
            children: [
              Text(
                'End Date',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '${DateFormat('EEE, dd/MM').format(budget.endDate).toString()}',
                  style: TextStyle(
                    fontSize: 35,
                  ),
                ),
              ),
              Text(
                '${DateFormat('yyyy').format(budget.endDate).toString()}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget buildSelectedDatesLarge({BuildContext context, Budget budget}) {
//   return Padding(
//     padding: EdgeInsets.only(top: 10, bottom: 10),
//     child: Column(
//       children: [
//         Column(
//           children: [
//             Text(
//               'Start Date',
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: Text(
//                 '${DateFormat('EEE, dd/MM').format(budget.startDate).toString()}',
//                 style: TextStyle(
//                   fontSize: 35,
//                 ),
//               ),
//             ),
//             Text(
//               '${DateFormat('yyyy').format(budget.startDate).toString()}',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         Container(
//           padding: EdgeInsets.only(top: 20, bottom: 20),
//           child: Icon(
//             Icons.arrow_downward,
//             size: 45,
//           ),
//         ),
//         Column(
//           children: [
//             Text(
//               'End Date',
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: Text(
//                 '${DateFormat('EEE, dd/MM').format(budget.endDate).toString()}',
//                 style: TextStyle(
//                   fontSize: 35,
//                 ),
//               ),
//             ),
//             Text(
//               '${DateFormat('yyyy').format(budget.endDate).toString()}',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
