import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'form_fields.dart';
import 'package:provider/provider.dart';
import 'package:groceries_budget_app/services/auth_service.dart';
import 'package:groceries_budget_app/services/database_service.dart';

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
    _amountSaved = (widget.budget.amountSaved).floor();
  }

  @override
  Widget build(BuildContext context) {
    final uid = context.read<AuthService>().getCurrentUser().uid;
    final DatabaseService databaseService = context.read<DatabaseService>();
    return Card(
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.purple[100]
          : Theme.of(context).cardColor,
      child: Container(
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
                          autofocus: false,
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

                        await databaseService.updateAmountUsed(
                            uid, widget.budget);
                        await databaseService.updateAmountSaved(
                            uid, widget.budget);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_circle),
                      color: Theme.of(context).accentColor,
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
                        await databaseService.updateAmountUsed(
                            uid, widget.budget);
                        await databaseService.updateAmountSaved(
                            uid, widget.budget);
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

  ElevatedButton generateAddMoneyBtn(int amount) {
    final uid = context.read<AuthService>().getCurrentUser().uid;
    final DatabaseService databaseService = context.read<DatabaseService>();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
      ),
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

        await databaseService.updateAmountUsed(uid, widget.budget);
        await databaseService.updateAmountSaved(uid, widget.budget);
      },
    );
  }
}
