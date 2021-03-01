import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/widgets/items_card_list.dart';
import 'package:groceries_budget_app/widgets/large_selected_dates.dart';
import 'package:groceries_budget_app/widgets/selected_dates.dart';

import 'edit_notes_view.dart';

class BudgetDetailsView extends StatelessWidget {
  final Budget budget;

  const BudgetDetailsView({Key key, @required this.budget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('Budget Details'),
              centerTitle: true,
              pinned: true,
              expandedHeight: 350,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: buildSelectedDatesLarge(
                    context: context,
                    budget: budget,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {},
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildSelectedDates(context, budget),
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
                              buildItemsCardList(context, budget),
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
                    child: totalDaysCard(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: notesCard(context),
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

  Widget totalDaysCard(BuildContext context) {
    return Card(
      color: Theme.of(context).brightness != Brightness.dark
          ? Colors.blue[400]
          : Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: AutoSizeText(
                'This is a ${budget.getTotalDaysofBudget().toString()} day budget',
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
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
                    'Trip Notes',
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
