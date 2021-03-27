import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:groceries_budget_app/my_provider.dart';
import 'package:groceries_budget_app/views/budget_details/budget_details_view.dart';
import 'package:groceries_budget_app/widgets/app_bar_home_button.dart';
import 'package:groceries_budget_app/widgets/large_selected_dates.dart';
import 'package:groceries_budget_app/widgets/rounded_button.dart';
import 'package:groceries_budget_app/widgets/snackbar.dart';

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

  // TODO: Find replacement  for date range picker
  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
        context: context,
        initialFirstDate: _startDate,
        initialLastDate: _endDate,
        firstDate: DateTime(DateTime.now().year - 50),
        lastDate: DateTime(DateTime.now().year + 50));
    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate = picked[0];
        widget.budget.startDate = _startDate;
        _endDate = picked[1];
        widget.budget.endDate = _endDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Edit Budget - Date'),
            actions: [AppBarHomeButton()],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                buildSelectedDatesLarge(
                  context: context,
                  budget: widget.budget,
                ),
                SizedBox(height: 60),
                buildButtons(context, widget.budget),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, Budget budget) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        roundedButton(
          color: Colors.deepPurpleAccent,
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
        roundedButton(
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
