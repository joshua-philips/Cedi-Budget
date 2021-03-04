import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:groceries_budget_app/my_provider.dart';
import 'package:groceries_budget_app/views/budget_details/budget_details_view.dart';
import 'package:groceries_budget_app/widgets/app_bar_home_button.dart';
import 'package:groceries_budget_app/widgets/snackbar.dart';

import 'package:intl/intl.dart';

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
                buildSelectedDates(context),
                SizedBox(height: 60),
                buildButtons(context, widget.budget),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectedDates(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Column(
            children: [
              Text('Start Date'),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '${DateFormat('EEE, dd/MM').format(_startDate).toString()}',
                  style: TextStyle(fontSize: 35),
                ),
              ),
              Text(
                '${DateFormat('yyyy').format(_startDate).toString()}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 30, bottom: 30),
            child: Icon(
              Icons.arrow_downward,
              size: 45,
              color: Theme.of(context).accentColor,
            ),
          ),
          Column(
            children: [
              Text('End Date'),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '${DateFormat('EEE, dd/MM').format(_endDate).toString()}',
                  style: TextStyle(fontSize: 35),
                ),
              ),
              Text(
                '${DateFormat('yyyy').format(_endDate).toString()}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, Budget budget) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          textColor: Colors.white,
          color: Colors.deepPurpleAccent,
          onPressed: () async {
            await displayDateRangePicker(context);
          },
        ),
        SizedBox(height: 20),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          textColor: Colors.white,
          color: Theme.of(context).accentColor,
          onPressed: () async {
            showLoadingSnackBar(_scaffoldKey);
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
              _scaffoldKey.currentState.hideCurrentSnackBar();
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).push(route);
            } catch (e) {
              _scaffoldKey.currentState.hideCurrentSnackBar();
              showMessageSnackBar(_scaffoldKey, e.message);
            }
          },
        ),
      ],
    );
  }
}
