import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/widgets/app_bar_home_button.dart';
import 'package:groceries_budget_app/widgets/date_field.dart';
import 'package:groceries_budget_app/widgets/rounded_button.dart';
import 'package:groceries_budget_app/widgets/selected_dates.dart';
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

  Future<DateTime> displayDatePicker(
      BuildContext context, DateTime initialDate) async {
    DateTime newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now().subtract(Duration(days: 365 * 50)),
      lastDate: DateTime.now().add(Duration(days: 365 * 50)),
    );
    return newDate ?? initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Date'),
        actions: [
          AppBarHomeButton(),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: SelectedDates(budget: widget.budget),
                    ),
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
              SizedBox(height: 15),
              DateField(
                label: 'Start Date',
                date: _startDate,
                icon: Icons.arrow_drop_down_rounded,
                onIconPressed: () async {
                  DateTime selectedDate =
                      await displayDatePicker(context, _startDate);

                  setState(() {
                    _startDate = selectedDate;
                    widget.budget.startDate = _startDate;
                  });
                },
              ),
              DateField(
                label: 'End Date',
                date: _endDate,
                icon: Icons.arrow_drop_down_rounded,
                onIconPressed: () async {
                  DateTime selectedDate =
                      await displayDatePicker(context, _endDate);

                  setState(() {
                    _endDate = selectedDate;
                    widget.budget.endDate = _endDate;
                  });
                },
              ),
              buildButtons(context, widget.budget),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtons(BuildContext context, Budget budget) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RoundedButton(
          color: Theme.of(context).accentColor,
          child: Text(
            'Continue',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
        SizedBox(height: 5),
        RoundedButton(
          color: Colors.deepPurple,
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
