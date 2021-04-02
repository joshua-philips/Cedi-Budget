import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/my_provider.dart';
import 'package:groceries_budget_app/views/budget_details/budget_details_view.dart';
import 'package:groceries_budget_app/widgets/rounded_button.dart';
import 'package:groceries_budget_app/widgets/selected_dates.dart';
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
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Change Dates',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SelectedDates(
                    budget: widget.budget,
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [TotalDaysText(budget: widget.budget)],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 2),
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
          color: Colors.green[900],
          child: Text(
            'Change Date Range',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: () async {
            await displayDateRangePicker(context);
          },
        ),
        RoundedButton(
          color: Theme.of(context).accentColor,
          child: Text(
            'Finish',
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
        Divider(thickness: 1.5),
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
