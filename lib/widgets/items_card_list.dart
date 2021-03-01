import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';

Widget buildItemsCardList(BuildContext context, Budget budget) {
  List<String> items = budget.items.keys.toList();
  List<double> prices = budget.items.values.toList();
  return ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    physics: NeverScrollableScrollPhysics(),
    itemCount: items.length,
    itemBuilder: (context, index) {
      return Card(
        child: ListTile(
          title: Text(items[index]),
          trailing: Text(
            'GH¢' + prices[index].toStringAsFixed(0),
          ),
        ),
      );
    },
  );
}
