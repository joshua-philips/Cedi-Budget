import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/my_provider.dart';
import 'package:groceries_budget_app/views/budget_details/budget_details_view.dart';
import 'package:groceries_budget_app/widgets/app_bar_home_button.dart';
import 'package:groceries_budget_app/widgets/rounded_button.dart';
import 'package:groceries_budget_app/widgets/selected_dates.dart';
import 'package:groceries_budget_app/widgets/snackbar.dart';
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('Change Dates'),
              actions: [AppBarHomeButton()],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Card(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        LargeSelectedDates(
                          budget: widget.budget,
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
              'Finish',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          onPressed: () async {
            showLoadingSnackBar(context);
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
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).push(route);
            } catch (e) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              showMessageSnackBar(context, e.message);
            }
          },
        ),
      ],
    );
  }
}
