import 'package:flutter/material.dart';
import 'package:groceries_budget_app/lorem.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.color,
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: Text('Cedi Budget 1.0.0'),
              floating: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: SingleChildScrollView(
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
