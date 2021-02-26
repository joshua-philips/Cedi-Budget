import 'package:flutter/material.dart';
import 'package:groceries_budget_app/lorem.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text('Groceries Budget 1.0.0'),
              floating: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          lorem,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
