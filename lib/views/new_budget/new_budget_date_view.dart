import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/widgets/app_bar_home_button.dart';
import 'package:groceries_budget_app/widgets/large_selected_dates.dart';
import 'package:groceries_budget_app/widgets/rounded_button.dart';
import 'package:groceries_budget_app/widgets/total_days_text.dart';
import 'new_budget_amount_view.dart';

class NewBudgetDateView extends StatefulWidget {
  final Budget budget;

  NewBudgetDateView({Key key, @required this.budget}) : super(key: key);

  @override
  _NewBudgetDateViewState createState() => _NewBudgetDateViewState();
}

class _NewBudgetDateViewState extends State<NewBudgetDateView> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(Duration(days: 7));

  // TODO: Date Range Picker app bar colours
  Future displayDateRangePicker(BuildContext context) async {
    DateTimeRange _initialDateRange = DateTimeRange(
      start: _startDate,
      end: _endDate,
    );
    DateTimeRange pickedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 365 * 50)),
      lastDate: DateTime.now().add(Duration(days: 365 * 50)),
      initialDateRange: _initialDateRange,
    );
    if (pickedRange != null) {
      setState(() {
        _startDate = pickedRange.start;
        _endDate = pickedRange.end;
        widget.budget.startDate = _startDate;
        widget.budget.endDate = _endDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('New Budget - Date'),
              actions: [AppBarHomeButton()],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Card(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        LargeSelectedDates(budget: widget.budget),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TotalDaysText(budget: widget.budget),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  buildButtons(context, widget.budget),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtons(BuildContext context, Budget budget) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RoundedButton(
          color: Colors.deepPurple,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 10,
              bottom: 10,
            ),
            child: Text(
              'Change Date Range',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          onPressed: () async {
            await displayDateRangePicker(context);
          },
        ),
        SizedBox(height: 20),
        RoundedButton(
          color: Theme.of(context).accentColor,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 10,
              bottom: 10,
            ),
            child: Text(
              'Continue',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          onPressed: () {
            widget.budget.startDate = _startDate;
            widget.budget.endDate = _endDate;
            Route route = MaterialPageRoute(
              builder: (context) => NewBudgetAmountView(budget: widget.budget),
            );
            Navigator.of(context).push(route);
          },
        ),
      ],
    );
  }
}
