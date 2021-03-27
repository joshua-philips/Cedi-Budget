import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/widgets/app_bar_home_button.dart';
import 'package:groceries_budget_app/widgets/divider_with_text.dart';
import 'package:groceries_budget_app/widgets/item_text_field.dart';
import 'package:groceries_budget_app/widgets/money_text_field.dart';
import 'package:groceries_budget_app/widgets/rounded_button.dart';

import 'new_budget_summary_view.dart';

enum amountType { simple, complex }

class NewBudgetAmountView extends StatefulWidget {
  final Budget budget;

  NewBudgetAmountView({Key key, @required this.budget}) : super(key: key);
  @override
  _NewBudgetAmountViewState createState() => _NewBudgetAmountViewState();
}

class _NewBudgetAmountViewState extends State<NewBudgetAmountView> {
  amountType _amountState = amountType.simple;
  String _switchButtonText = 'Build Budget';
  var _amountTotal = 0;

  TextEditingController _amountController = TextEditingController();
  // Items
  TextEditingController _item1 = TextEditingController();
  TextEditingController _item2 = TextEditingController();
  TextEditingController _item3 = TextEditingController();
  TextEditingController _item4 = TextEditingController();
  TextEditingController _item5 = TextEditingController();

  // Prices
  TextEditingController _itemPrice1 = TextEditingController();
  TextEditingController _itemPrice2 = TextEditingController();
  TextEditingController _itemPrice3 = TextEditingController();
  TextEditingController _itemPrice4 = TextEditingController();
  TextEditingController _itemPrice5 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_setTotalAmount);
    _itemPrice1.addListener(_setTotalAmount);
    _itemPrice2.addListener(_setTotalAmount);
    _itemPrice3.addListener(_setTotalAmount);
    _itemPrice4.addListener(_setTotalAmount);
    _itemPrice5.addListener(_setTotalAmount);
  }

  _setTotalAmount() {
    var total = 0;
    if (_amountState == amountType.simple) {
      total =
          _amountController.text == '' ? 0 : int.parse(_amountController.text);
      setState(() {
        _amountTotal = total;
      });
    } else {
      total += _itemPrice1.text == '' ? 0 : int.parse(_itemPrice1.text);
      total += _itemPrice2.text == '' ? 0 : int.parse(_itemPrice2.text);
      total += _itemPrice3.text == '' ? 0 : int.parse(_itemPrice3.text);
      total += _itemPrice4.text == '' ? 0 : int.parse(_itemPrice4.text);
      total += _itemPrice5.text == '' ? 0 : int.parse(_itemPrice5.text);
      setState(() {
        _amountTotal = total;
        _amountController.text = _amountTotal.toString();
      });
    }
  }

  List<Widget> setAmountFields(_amountController) {
    List<Widget> fields = [];
    if (_amountState == amountType.simple) {
      _switchButtonText = 'Build Budget';
      fields.add(
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            'Enter your total budget for the period',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
      fields.add(
        Padding(
          padding: const EdgeInsets.only(right: 50),
          child: MoneyTextField(
            controller: _amountController,
            helperText: 'Total Budget',
            autofocus: true,
          ),
        ),
      );
    } else {
      fields.add(
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            'Enter cost of each item',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
      fields.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ItemTextField(controller: _item1),
            ),
            Expanded(
              child: MoneyTextField(
                controller: _itemPrice1,
              ),
            ),
          ],
        ),
      );
      fields.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ItemTextField(controller: _item2),
            ),
            Expanded(
              child: MoneyTextField(
                controller: _itemPrice2,
              ),
            ),
          ],
        ),
      );
      fields.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ItemTextField(controller: _item3),
            ),
            Expanded(
              child: MoneyTextField(
                controller: _itemPrice3,
              ),
            ),
          ],
        ),
      );
      fields.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ItemTextField(controller: _item4),
            ),
            Expanded(
              child: MoneyTextField(
                controller: _itemPrice4,
              ),
            ),
          ],
        ),
      );
      fields.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ItemTextField(controller: _item5),
            ),
            Expanded(
              child: MoneyTextField(
                controller: _itemPrice5,
              ),
            ),
          ],
        ),
      );
      fields.add(
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Text(
            'Total: GH¢$_amountTotal',
            style: TextStyle(fontSize: 25),
          ),
        ),
      );
      _switchButtonText = 'Simple Budget';
    }
    return fields;
  }

  /// Convert textfield items in complex mode.
  /// Also determines if Budget variable hasItems is true/false
  Map<String, double> changeItemsToMap() {
    Map<String, double> budgetItemsAndPrices = {};

    if (_amountState == amountType.complex) {
      if (_item1.text != '' && _itemPrice1.text != '') {
        budgetItemsAndPrices
            .addAll({_item1.text: double.parse(_itemPrice1.text)});
        widget.budget.hasItems = true;
      }
      if (_item2.text != '' && _itemPrice2.text != '') {
        budgetItemsAndPrices
            .addAll({_item2.text: double.parse(_itemPrice2.text)});
        widget.budget.hasItems = true;
      }
      if (_item3.text != '' && _itemPrice3.text != '') {
        budgetItemsAndPrices
            .addAll({_item3.text: double.parse(_itemPrice3.text)});
        widget.budget.hasItems = true;
      }
      if (_item4.text != '' && _itemPrice4.text != '') {
        budgetItemsAndPrices
            .addAll({_item4.text: double.parse(_itemPrice4.text)});
        widget.budget.hasItems = true;
      }
      if (_item5.text != '' && _itemPrice5.text != '') {
        budgetItemsAndPrices
            .addAll({_item5.text: double.parse(_itemPrice5.text)});
        widget.budget.hasItems = true;
      }
    }

    return budgetItemsAndPrices;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Amount/Items'),
            actions: [
              AppBarHomeButton(),
              IconButton(
                padding: EdgeInsets.only(right: 10),
                tooltip: 'Summary',
                icon: Icon(Icons.done_all),
                onPressed: () {
                  continueToSummary();
                },
              ),
            ],
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: setAmountFields(_amountController) +
                        [
                          roundedButton(
                            color: Theme.of(context).accentColor,
                            child: Text(
                              'Continue to summary',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              continueToSummary();
                            },
                          ),
                          DividerWithText(dividerText: 'or'),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Center(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.only(left: 8),
                                  minimumSize: Size(0, 0),
                                ),
                                child: Text(
                                  _switchButtonText,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _amountState =
                                        _amountState == amountType.simple
                                            ? amountType.complex
                                            : amountType.simple;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  continueToSummary() {
    widget.budget.amount = _amountTotal.toDouble();
    widget.budget.items = changeItemsToMap();

    Route route = MaterialPageRoute(
      builder: (context) => NewBudgetSummaryView(budget: widget.budget),
    );
    Navigator.push(context, route);
  }
}
