import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/views/new_budget/new_budget_date_view.dart';
import 'package:groceries_budget_app/widgets/budget_card.dart';
import 'package:provider/provider.dart';
import 'package:groceries_budget_app/services/auth_service.dart';
import 'package:groceries_budget_app/services/database_service.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String uid = context.read<AuthService>().getCurrentUser().uid;
    return Container(
      child: StreamBuilder(
        stream:
            context.watch<DatabaseService>().getUsersBudgetStreamSnapshot(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data.docs.length != 0) {
              return buildBudgetList(context, snapshot);
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(
                child: noData(context),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildBudgetList(BuildContext context, AsyncSnapshot snapshot) {
    return Scrollbar(
      thickness: 2,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: snapshot.data.docs.length,
        padding: EdgeInsets.only(top: 10, bottom: 70),
        itemBuilder: (context, int index) {
          return BudgetCard(documentSnapshot: snapshot.data.docs[index]);
        },
      ),
    );
  }

  Widget noData(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to Cedi Budget.\nYou do not have a budget at this time. Press the button below to add your new budget.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).accentColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: 10,
              ),
              child: Text(
                'Create new budget',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            onPressed: () {
              Route route = MaterialPageRoute(
                builder: (context) => NewBudgetDateView(
                  budget: Budget.noArgument(),
                ),
              );
              Navigator.push(context, route);
            },
          ),
        ],
      ),
    );
  }
}
