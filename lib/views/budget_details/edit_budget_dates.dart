import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/my_provider.dart';
import 'package:groceries_budget_app/views/budget_details/budget_details_view.dart';
import 'package:groceries_budget_app/widgets/date_field.dart';
import 'package:groceries_budget_app/widgets/rounded_button.dart';
import 'package:groceries_budget_app/widgets/snackbar_and_loading.dart';
import 'package:groceries_budget_app/widgets/total_days_text.dart';

class EditBudgetDatesView extends StatefulWidget {
  final Budget budget;

  const EditBudgetDatesView({Key key, @required this.budget}) : super(key: key);
  @override
  _EditBudgetDatesViewState createState() => _EditBudgetDatesViewState();
}

class _EditBudgetDatesViewState extends State<EditBudgetDatesView> {
  DateTime _startDate;
  DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.budget.startDate;
    _endDate = widget.budget.endDate;
  }

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
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              'Change Dates',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                TotalDaysText(budget: widget.budget),
              ],
            ),
          ),
          SizedBox(height: 15),
          buildButtons(context, widget.budget),
        ],
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
            'Update',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () async {
            showLoadingDialog(context);
            widget.budget.startDate = _startDate;
            widget.budget.endDate = _endDate;
            final uid = MyProvider.of(context).auth.getCurrentUID();
            Route route = MaterialPageRoute(
                builder: (context) => BudgetDetailsView(
                      budget: widget.budget,
                    ));
            try {
              await MyProvider.of(context)
                  .database
                  .updateDates(uid, widget.budget);
              hideLoadingDialog(context);
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).push(route);
            } catch (e) {
              hideLoadingDialog(context);
              showMessageSnackBar(context, e.message);
            }
          },
        ),
        SizedBox(height: 2),
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
