import 'package:flutter/material.dart';
import 'package:groceries_budget_app/widgets/budget_card.dart';
import 'package:provider/provider.dart';
import 'package:groceries_budget_app/services/auth_service.dart';
import 'package:groceries_budget_app/services/database_service.dart';

class BudgetHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String uid = context.read<AuthService>().getCurrentUser().uid;
    return Container(
      child: StreamBuilder(
        stream: context.watch<DatabaseService>().getPastBudgetsStream(uid),
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
                child: Text(
                  'No Past Budgets',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
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
}
