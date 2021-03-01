import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/widgets/app_bar_home_button.dart';
import 'package:groceries_budget_app/widgets/items_card_list.dart';
import 'package:groceries_budget_app/widgets/selected_dates.dart';

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
            actions: [AppBarHomeButton()],
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
                        'Summary',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(),
                      ListTile(title: buildSelectedDates(context, budget)),
                      Divider(),
                      SizedBox(height: 15),
                      budget.hasItems
                          ? buildItemsCardList(context, budget)
                          : Container(),
                      SizedBox(height: 20),
                      ListTile(
                        title: Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Text(
                          'GH¢' + budget.amount.toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
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
                          // Save data to firebase
                          final String uid =
                              MyProvider.of(context).auth.getCurrentUID();
                          try {
                            await MyProvider.of(context)
                                .database
                                .saveBudgetToFirestore(budget, uid);
                            _scaffoldKey.currentState.hideCurrentSnackBar();
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                          } catch (e) {
                            print(e);
                            _scaffoldKey.currentState.hideCurrentSnackBar();
                            showErrorSnackBar(_scaffoldKey, e.message);
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

  void showLoadingSnackBar(GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(days: 1),
        content: Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: SpinKitWave(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  void showErrorSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String error) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        error,
        style: TextStyle(color: Colors.white),
      ),
    ));
  }
}
