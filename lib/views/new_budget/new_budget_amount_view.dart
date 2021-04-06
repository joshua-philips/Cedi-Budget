import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
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
  String _switchButtonText;
  double _amountTotal = 0;

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

    _switchButtonText = _amountState == amountType.simple
        ? 'Input each item'
        : 'Input total only';
  }

  _setTotalAmount() {
    double total = 0;
    if (_amountState == amountType.simple) {
      total = _amountController.text == ''
          ? 0
          : double.parse(_amountController.text);
      setState(() {
        _amountTotal = total;
      });
    } else {
      total += _itemPrice1.text == '' ? 0 : double.parse(_itemPrice1.text);
      total += _itemPrice2.text == '' ? 0 : double.parse(_itemPrice2.text);
      total += _itemPrice3.text == '' ? 0 : double.parse(_itemPrice3.text);
      total += _itemPrice4.text == '' ? 0 : double.parse(_itemPrice4.text);
      total += _itemPrice5.text == '' ? 0 : double.parse(_itemPrice5.text);
      setState(() {
        _amountTotal = total;
        _amountController.text = _amountTotal.toStringAsFixed(2);
      });
    }
  }

  List<Widget> setAmountFields(_amountController) {
    List<Widget> fields = [];
    if (_amountState == amountType.simple) {
      fields.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Input total budget for the period',
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
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Input cost of each item',
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
            'Total: GH¢${_amountTotal.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 25),
          ),
        ),
      );
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
      appBar: AppBar(
        title: Text(''),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              padding: EdgeInsets.only(right: 25, left: 25),
              primary: Theme.of(context).accentColor,
            ),
            onPressed: () {
              setState(() {
                _amountState = _amountState == amountType.simple
                    ? amountType.complex
                    : amountType.simple;

                _switchButtonText = _amountState == amountType.simple
                    ? 'Input each item'
                    : 'Input total only';
              });
            },
            icon: Icon(
              _amountState != amountType.simple
                  ? Icons.add_circle_outline
                  : Icons.list_rounded,
            ),
            label: Text(
              _switchButtonText,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Text(
                      'Summary',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText2.color,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                continueToSummary();
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children: setAmountFields(_amountController) +
                    [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: RoundedButton(
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
                      ),
                    ],
              ),
            ),
          ),
        ),
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
