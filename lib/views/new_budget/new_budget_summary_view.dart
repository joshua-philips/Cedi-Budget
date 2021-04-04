import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/widgets/app_bar_home_button.dart';
import 'package:groceries_budget_app/widgets/items_card_list.dart';
import 'package:groceries_budget_app/widgets/rounded_button.dart';
import 'package:groceries_budget_app/widgets/selected_dates.dart';
import 'package:groceries_budget_app/widgets/snackbar_and_loading.dart';
import 'package:groceries_budget_app/widgets/total_budget_card.dart';
import 'package:groceries_budget_app/widgets/total_days_text.dart';

import '../../my_provider.dart';

class NewBudgetSummaryView extends StatelessWidget {
  final Budget budget;

  NewBudgetSummaryView({Key key, @required this.budget}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('New Budget'),
            actions: [
              AppBarHomeButton(),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          'Finish',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyText2.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    showLoadingDialog(context);
                    final String uid =
                        MyProvider.of(context).auth.getCurrentUID();
                    try {
                      await MyProvider.of(context)
                          .database
                          .saveBudgetToFirestore(budget, uid);
                      hideLoadingDialog(context);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    } catch (e) {
                      print(e);
                      showMessageSnackBar(context, e.message);
                    }
                  },
                ),
              ),
            ],
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Budget Summary',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(),
                      ListTile(
                        title: SelectedDates(budget: budget),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TotalDaysText(budget: budget),
                        ),
                      ),
                      Divider(),
                      SizedBox(height: 15),
                      budget.hasItems
                          ? ItemsCardList(budget: budget)
                          : Container(),
                      SizedBox(height: 20),
                      TotalBudgetCard(budget: budget),
                      SizedBox(height: 30),
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
                          showLoadingDialog(context);
                          final String uid =
                              MyProvider.of(context).auth.getCurrentUID();
                          try {
                            await MyProvider.of(context)
                                .database
                                .saveBudgetToFirestore(budget, uid);
                            hideLoadingDialog(context);
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          } catch (e) {
                            print(e);
                            showMessageSnackBar(context, e.message);
                          }
                        },
                      ),
                      Container(height: 60),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
