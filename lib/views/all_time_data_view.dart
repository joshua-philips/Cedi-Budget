import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/my_provider.dart';
import 'package:groceries_budget_app/widgets/app_bar_home_button.dart';

class AllTimeDataView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String uid = MyProvider.of(context).auth.getCurrentUID();
    return Scaffold(
      appBar: AppBar(
        title: Text('All-Time Budget Data'),
        actions: [
          AppBarHomeButton(),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: MyProvider.of(context).database.getAllBudgets(uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: buildAllTimmeTotals(snapshot),
                );
              } else {
                return Container();
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildAllTimmeTotals(snapshot) {
    double amountTotal = 0;
    double usedTotal = 0;
    double savedTotal = 0;

    for (int count = 0; count < snapshot.data.length; count++) {
      amountTotal =
          amountTotal + Budget.fromSnapshot(snapshot.data[count]).amount;
      usedTotal =
          usedTotal + Budget.fromSnapshot(snapshot.data[count]).amountUsed;
      savedTotal = amountTotal - usedTotal;
    }
    return Container(
      child: Column(
        children: [
          Text(
            'Financial Summary',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            title: Text(
              'Total Amount Set:',
            ),
            trailing: Text(
              'GH¢' + (amountTotal ?? 0.00).toStringAsFixed(2),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Total Amount Spent:',
            ),
            trailing: Text(
              'GH¢' + (usedTotal ?? 0.00).toStringAsFixed(2),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Total Amount Saved:',
            ),
            trailing: Text(
              'GH¢' + (savedTotal ?? 0.00).toStringAsFixed(2),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
