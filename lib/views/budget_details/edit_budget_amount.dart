import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/my_provider.dart';
import 'package:groceries_budget_app/views/budget_details/budget_details_view.dart';
import 'package:groceries_budget_app/widgets/item_text_field.dart';
import 'package:groceries_budget_app/widgets/money_text_field.dart';
import 'package:groceries_budget_app/widgets/rounded_button.dart';
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
  String _switchButtonText;
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
      _switchButtonText = 'Input total only';
    } else {
      _amountState = amountType.simple;
      _switchButtonText = 'Input each item';
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
      fields.add(Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          'Enter your total budget for the period',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
      fields.add(
        Padding(
          padding: const EdgeInsets.only(right: 50),
          child: MoneyTextField(
            controller: _amountController,
            helperText: 'Total Budget',
          ),
        ),
      );
    } else {
      fields.add(Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          'Enter cost of each item',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
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
      appBar: AppBar(
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Theme.of(context).accentColor,
              padding: EdgeInsets.only(right: 25),
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
          IconButton(
            padding: EdgeInsets.only(right: 10),
            tooltip: 'Save',
            icon: Icon(Icons.save),
            onPressed: () {
              finish();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: setAmountFields(_amountController) +
                    [
                      RoundedButton(
                        child: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          finish();
                        },
                      ),
                    ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  finish() async {
    showLoadingSnackBar(context);
    widget.budget.amount = _amountTotal.toDouble();
    widget.budget.items = changeItemsToMap();
    final uid = MyProvider.of(context).auth.getCurrentUID();
    Route route = MaterialPageRoute(
      builder: (context) => BudgetDetailsView(budget: widget.budget),
    );
    try {
      await MyProvider.of(context)
          .database
          .updateAmountAndItems(uid, widget.budget);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.push(context, route);
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      showMessageSnackBar(context, e.message);
    }
  }
}
