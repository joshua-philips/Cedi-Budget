import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/views/budget_details/deposit_view.dart';
import 'package:groceries_budget_app/views/budget_details/edit_budget_amount.dart';
import 'package:groceries_budget_app/widgets/calculator_widget.dart';
import 'package:groceries_budget_app/widgets/items_card_list.dart';
import 'package:groceries_budget_app/widgets/large_selected_dates.dart';
import 'package:groceries_budget_app/widgets/total_days_text.dart';

import '../../my_provider.dart';
import '../budget_details/edit_notes_view.dart';
import 'edit_budget_dates.dart';

class BudgetDetailsView extends StatelessWidget {
  final Budget budget;

  BudgetDetailsView({Key key, this.budget}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('Details'),
              pinned: true,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(Icons.format_list_bulleted),
                        SizedBox(width: 5),
                        Text(
                          'Edit Budget & Items',
                          style: TextStyle(
                            color: Theme.of(context)
                                .appBarTheme
                                .textTheme
                                .headline6
                                .color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Route route = MaterialPageRoute(
                        builder: (context) =>
                            EditBudgetAmountView(budget: budget),
                      );
                      Navigator.push(context, route);
                    },
                  ),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8),
                    child: Card(
                      child: Column(
                        children: [
                          LargeSelectedDates(
                            budget: budget,
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 8, bottom: 8),
                            child: Row(
                              children: [
                                TotalDaysText(budget: budget),
                                Spacer(),
                                TextButton.icon(
                                  icon: Icon(Icons.calendar_today_outlined),
                                  label: Text(
                                    'Edit Dates',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    Route route = MaterialPageRoute(
                                      builder: (context) => EditBudgetDatesView(
                                        budget: budget,
                                      ),
                                    );
                                    Navigator.of(context).push(route);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  budget.hasItems
                      ? Padding(
                          padding: const EdgeInsets.only(
                              top: 16, left: 8.0, right: 8),
                          child: Column(
                            children: [
                              Text(
                                'Items in your budget:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ItemsCardList(budget: budget),
                            ],
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: totalBudgetCard(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: CalculatorWidget(budget: budget),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: notesCard(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: deleteBudgetButton(context, budget),
                  ),
                  Container(
                    height: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: Text(
          '¢',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
          ),
        ),
        onPressed: () {
          Route route = MaterialPageRoute(
              builder: (context) => DepositView(budget: budget));
          Navigator.push(context, route);
        },
      ),
    );
  }

  Widget deleteBudgetButton(BuildContext context, Budget budget) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        padding: EdgeInsets.only(top: 15),
      ),
      icon: Icon(
        Icons.delete,
        size: 30,
        color: Colors.red,
      ),
      label: Text(
        'Delete budget',
        style: TextStyle(
          fontSize: 20,
          color: Colors.red,
        ),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Delete this budget',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Are you sure you want to delete this budget? Deleted items cannot be retieved.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.only(right: 20),
                          ),
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: Colors.red,
                            ),
                          ),
                          onPressed: () async {
                            final uid =
                                MyProvider.of(context).auth.getCurrentUID();
                            await MyProvider.of(context)
                                .database
                                .deleteBudget(uid, budget);
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.only(right: 10),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color:
                                  Theme.of(context).textTheme.bodyText2.color,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget totalBudgetCard(BuildContext context) {
    return Card(
      color: Theme.of(context).brightness != Brightness.dark
          ? Colors.green[400]
          : Theme.of(context).cardColor,
      child: ListTile(
        title: Text(
          'Total:',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Text(
          'GH¢' + budget.amount.toStringAsFixed(0),
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget notesCard(BuildContext context) {
    return Card(
      color: Theme.of(context).brightness != Brightness.dark
          ? Colors.amberAccent
          : Theme.of(context).cardColor,
      child: InkWell(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Budget Notes',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: setNoteText(),
            ),
          ],
        ),
        onTap: () {
          Route route = MaterialPageRoute(
              builder: (context) => EditNotesView(budget: budget));
          Navigator.push(context, route);
        },
      ),
    );
  }

  List<Widget> setNoteText() {
    if (budget.notes == null || budget.notes == '') {
      return [
        Padding(
          padding: const EdgeInsets.only(
            top: 5,
            left: 10,
            right: 10,
            bottom: 10,
          ),
          child: Icon(Icons.add_circle_outline),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 5,
            right: 10,
            bottom: 10,
          ),
          child: Text(
            'Click to add notes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ];
    } else {
      return [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 5,
              left: 10,
              right: 10,
              bottom: 10,
            ),
            child: AutoSizeText(
              budget.notes,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ];
    }
  }
}
