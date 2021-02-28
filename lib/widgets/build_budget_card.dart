import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/widgets/selected_dates.dart';

Widget buildBudgetCard(BuildContext context, DocumentSnapshot document) {
    final Budget budget = Budget.fromSnapshot(document);

    return Container(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: buildSelectedDates(context, budget),
              ),
              budget.hasItems != true
                  ? SizedBox(height: 20)
                  : buildCardItemsList(context, budget),
              Padding(
                padding: const EdgeInsets.only(right: 30, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AutoSizeText(
                      'GH¢' + budget.amount.toStringAsFixed(2),
                      style: TextStyle(fontSize: 35),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }

  Widget buildCardItemsList(context, Budget budget) {
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