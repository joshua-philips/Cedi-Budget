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
            if (snapshot.hasData) {
              return buildBudgetList(context, snapshot);
            } else {
              return Text('No data. Add your new budget');
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
    return ListView.builder(
      itemCount: snapshot.data.docs.length,
      itemBuilder: (context, int index) {
        return buildBudgetCard(context, snapshot.data.docs[index]);
      },
    );
  }
}
