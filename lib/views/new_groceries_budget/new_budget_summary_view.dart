import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';

class NewBudgetSummaryView extends StatelessWidget {
  final Budget budget;

  const NewBudgetSummaryView({Key key, @required this.budget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('New Budget - Summary'),
            floating: true,
          ),

          // TODO: If budget.hasItems is true display each item and price
        ],
      ),
    );
  }
}
