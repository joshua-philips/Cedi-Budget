import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/widgets/money_text_field.dart';

import '../my_provider.dart';

class CalculatorWidget extends StatefulWidget {
  final Budget budget;

  const CalculatorWidget({Key key, @required this.budget}) : super(key: key);

  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  TextEditingController _moneyController = TextEditingController();
  int _amountSaved = 0;
  int _amountUsed = 0;

  @override
  void initState() {
    super.initState();
    _amountUsed = (widget.budget.amountUsed ?? 0.0).floor();
    _amountSaved =
        (widget.budget.amount - (widget.budget.amountUsed ?? 0.0)).floor();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.purple[100]
            : Theme.of(context).cardColor,
        child: Column(
          children: [
            Container(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.purple[200]
                  : Theme.of(context).cardColor,
              child: Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          AutoSizeText(
                            'GH¢$_amountUsed',
                            maxLines: 1,
                            style: TextStyle(fontSize: 40),
                          ),
                          Text('Used', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      child: VerticalDivider(
                        color: Theme.of(context).textTheme.bodyText2.color,
                        thickness: 4,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        children: [
                          AutoSizeText(
                            'GH¢$_amountSaved',
                            maxLines: 1,
                            style: TextStyle(fontSize: 40),
                          ),
                          Text('Saved', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Theme.of(context).brightness == Brightness.light
                ? Container()
                : Divider(),
            Container(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: MoneyTextField(
                          controller: _moneyController,
                          helperText: 'Add to used',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle),
                      color: Colors.green,
                      iconSize: 40,
                      onPressed: () async {
                        setState(() {
                          _amountUsed =
                              _amountUsed + int.parse(_moneyController.text);
                          _amountSaved =
                              _amountSaved - int.parse(_moneyController.text);
                          widget.budget.amountSaved = _amountSaved.toDouble();
                          widget.budget.amountUsed = _amountUsed.toDouble();
                        });

                        final uid = MyProvider.of(context).auth.getCurrentUID();
                        await MyProvider.of(context)
                            .database
                            .updateAmountUsed(uid, widget.budget);
                        await MyProvider.of(context)
                            .database
                            .updateAmountSaved(uid, widget.budget);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_circle),
                      color: Colors.red,
                      iconSize: 40,
                      onPressed: () async {
                        setState(() {
                          _amountUsed =
                              _amountUsed - int.parse(_moneyController.text);
                          _amountSaved =
                              _amountSaved + int.parse(_moneyController.text);
                          widget.budget.amountSaved = _amountSaved.toDouble();
                          widget.budget.amountUsed = _amountUsed.toDouble();
                        });
                        final uid = MyProvider.of(context).auth.getCurrentUID();
                        await MyProvider.of(context)
                            .database
                            .updateAmountUsed(uid, widget.budget);
                        await MyProvider.of(context)
                            .database
                            .updateAmountSaved(uid, widget.budget);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    generateAddMoneyBtn(10),
                    generateAddMoneyBtn(20),
                    generateAddMoneyBtn(50),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  RaisedButton generateAddMoneyBtn(int amount) {
    final uid = MyProvider.of(context).auth.getCurrentUID();
    return RaisedButton(
      color: Colors.green,
      child: Text(
        'GH¢$amount',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        setState(() {
          _amountUsed = _amountUsed + amount;
          _amountSaved = _amountSaved - amount;
          widget.budget.amountSaved = _amountSaved.toDouble();
          widget.budget.amountUsed = _amountUsed.toDouble();
        });

        await MyProvider.of(context)
            .database
            .updateAmountUsed(uid, widget.budget);
        await MyProvider.of(context)
            .database
            .updateAmountSaved(uid, widget.budget);
      },
    );
  }
}
