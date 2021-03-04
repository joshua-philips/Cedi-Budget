import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/my_provider.dart';
import 'package:groceries_budget_app/views/budget_details/budget_details_view.dart';
import 'package:groceries_budget_app/widgets/app_bar_home_button.dart';
import 'package:groceries_budget_app/widgets/divider_with_text.dart';
import 'package:groceries_budget_app/widgets/item_text_field.dart';
import 'package:groceries_budget_app/widgets/money_text_field.dart';
import 'package:groceries_budget_app/widgets/snackbar.dart';

enum amountType { simple, complex }

class EditBudgetAmountView extends StatefulWidget {
  final Budget budget;

  const EditBudgetAmountView({Key key, @required this.budget})
      : super(key: key);
  @override
  _EditBudgetAmountViewState createState() => _EditBudgetAmountViewState();
}

class _EditBudgetAmountViewState extends State<EditBudgetAmountView> {
  amountType _amountState;
  String _switchButtonText = 'Build Budget';
  var _amountTotal;
  List<String> items;
  List<double> prices;

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
    _amountTotal = widget.budget.amount.floor();
    _amountController.text = _amountTotal.toString();
    initializeItemsFields();

    _amountController.addListener(_setTotalAmount);
    _itemPrice1.addListener(_setTotalAmount);
    _itemPrice2.addListener(_setTotalAmount);
    _itemPrice3.addListener(_setTotalAmount);
    _itemPrice4.addListener(_setTotalAmount);
    _itemPrice5.addListener(_setTotalAmount);

    if (widget.budget.hasItems) {
      _amountState = amountType.complex;
    } else {
      _amountState = amountType.simple;
    }
  }

  initializeItemsFields() {
    items = widget.budget.items.keys.toList();
    prices = widget.budget.items.values.toList();

    if (items.length == 5) {
      _item1.text = items[0];
      _itemPrice1.text = prices[0].toStringAsFixed(0);
      _item2.text = items[1];
      _itemPrice2.text = prices[1].toStringAsFixed(0);
      _item3.text = items[2];
      _itemPrice3.text = prices[2].toStringAsFixed(0);
      _item4.text = items[3];
      _itemPrice4.text = prices[3].toStringAsFixed(0);
      _item5.text = items[4];
      _itemPrice5.text = prices[4].toStringAsFixed(0);
    }
    if (items.length == 4) {
      _item1.text = items[0];
      _itemPrice1.text = prices[0].toStringAsFixed(0);
      _item2.text = items[1];
      _itemPrice2.text = prices[1].toStringAsFixed(0);
      _item3.text = items[2];
      _itemPrice3.text = prices[2].toStringAsFixed(0);
      _item4.text = items[3];
      _itemPrice4.text = prices[3].toStringAsFixed(0);
    }
    if (items.length == 3) {
      _item1.text = items[0];
      _itemPrice1.text = prices[0].toStringAsFixed(0);
      _item2.text = items[1];
      _itemPrice2.text = prices[1].toStringAsFixed(0);
      _item3.text = items[2];
      _itemPrice3.text = prices[2].toStringAsFixed(0);
    }
    if (items.length == 2) {
      _item1.text = items[0];
      _itemPrice1.text = prices[0].toStringAsFixed(0);
      _item2.text = items[1];
      _itemPrice2.text = prices[1].toStringAsFixed(0);
    }
    if (items.length == 1) {
      _item1.text = items[0];
      _itemPrice1.text = prices[0].toStringAsFixed(0);
    }
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
      fields.add(Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('Enter your total budget for the period'),
      ));
      fields.add(
        MoneyTextField(
          controller: _amountController,
          helperText: 'Total Budget',
        ),
      );
    } else {
      fields.add(Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text('Enter cost of each item'),
      ));
      fields.add(
        ItemTextField(controller: _item1),
      );
      fields.add(MoneyTextField(
        controller: _itemPrice1,
      ));
      fields.add(
        ItemTextField(controller: _item2),
      );
      fields.add(MoneyTextField(
        controller: _itemPrice2,
      ));
      fields.add(
        ItemTextField(controller: _item3),
      );
      fields.add(MoneyTextField(
        controller: _itemPrice3,
      ));
      fields.add(
        ItemTextField(controller: _item4),
      );
      fields.add(MoneyTextField(
        controller: _itemPrice4,
      ));
      fields.add(
        ItemTextField(controller: _item5),
      );
      fields.add(MoneyTextField(
        controller: _itemPrice5,
      ));
      fields.add(Text('Total: GH¢$_amountTotal'));
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
    } else {
      widget.budget.hasItems = false;
    }

    return budgetItemsAndPrices;
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Amount/Items'),
            actions: [AppBarHomeButton()],
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  children: setAmountFields(_amountController) +
                      [
                        FlatButton(
                          child: Text(
                            'Finish',
                            style: TextStyle(fontSize: 25, color: Colors.blue),
                          ),
                          onPressed: () async {
                            showLoadingSnackBar(_scaffoldKey);
                            widget.budget.amount = _amountTotal.toDouble();
                            widget.budget.items = changeItemsToMap();
                            final uid =
                                MyProvider.of(context).auth.getCurrentUID();
                            Route route = MaterialPageRoute(
                              builder: (context) =>
                                  BudgetDetailsView(budget: widget.budget),
                            );
                            try {
                              await MyProvider.of(context)
                                  .database
                                  .updateAmountAndItems(uid, widget.budget);
                              _scaffoldKey.currentState.hideCurrentSnackBar();
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                              Navigator.push(context, route);
                            } catch (e) {
                              _scaffoldKey.currentState.hideCurrentSnackBar();
                              showMessageSnackBar(_scaffoldKey, e.message);
                            }
                          },
                        ),
                        DividerWithText(dividerText: 'or'),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Center(
                            child: FlatButton(
                              textColor: Colors.blue,
                              child: Text(
                                _switchButtonText,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600),
                              ),
                              minWidth: 0,
                              padding: EdgeInsets.only(left: 8),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}