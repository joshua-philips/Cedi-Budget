import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/views/budget_details/budget_details_view.dart';
import 'package:groceries_budget_app/widgets/selected_dates.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BudgetCard extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;

  const BudgetCard({Key key, @required this.documentSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Budget budget = Budget.fromSnapshot(documentSnapshot);

    return Container(
      padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Card(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Theme.of(context).cardColor,
        child: InkWell(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: FullDates(budget: budget),
                ),
              ),
              budget.hasItems != true
                  ? SizedBox(height: 20)
                  : buildCardItemsSmallList(context, budget),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 30, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularPercentIndicator(
                      radius: 50,
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Theme.of(context).accentColor,
                      percent: calculatePercentUsed(budget),
                      backgroundWidth: -2,
                      center: Text(
                        '${(calculatePercentUsed(budget) * 100).toStringAsFixed(0)}%\nUsed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Flexible(
                      child: AutoSizeText(
                        'GH¢' + budget.amount.toStringAsFixed(2),
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            Route route = MaterialPageRoute(
                builder: (context) => BudgetDetailsView(budget: budget));
            Navigator.of(context).push(route);
          },
        ),
      ),
    );
  }

  double calculatePercentUsed(Budget budget) {
    return (budget.amountUsed + budget.amountSaved) / budget.amount;
  }

  Widget buildCardItemsSmallList(BuildContext context, Budget budget) {
    List<String> items = budget.items.keys.toList();
    List<double> prices = budget.items.values.toList();
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 5),
            child: Row(
              children: [
                Text(items[index]),
                Spacer(),
                Text('GH¢' + prices[index].toStringAsFixed(2)),
              ],
            ),
          );
        },
      ),
    );
  }
}
