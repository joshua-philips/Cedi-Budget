import 'package:flutter/material.dart';
import 'package:groceries_budget_app/my_provider.dart';
import 'package:groceries_budget_app/widgets/build_budget_card.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String uid = MyProvider.of(context).auth.getCurrentUID();
    return Container(
      child: StreamBuilder(
        stream:
            MyProvider.of(context).database.getUsersBudgetStreamSnapshot(uid),
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
                child: Text('No data. Add your new budget'),
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
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context, int index) {
          return buildBudgetCard(context, snapshot.data.docs[index]);
        },
      ),
    );
  }
}
