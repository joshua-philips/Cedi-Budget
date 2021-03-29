import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/my_provider.dart';
import 'package:groceries_budget_app/views/budget_details/budget_details_view.dart';
import 'package:groceries_budget_app/widgets/rounded_button.dart';
import 'package:groceries_budget_app/widgets/snackbar.dart';

class DepositView extends StatefulWidget {
  final Budget budget;

  const DepositView({Key key, @required this.budget}) : super(key: key);
  @override
  _DepositViewState createState() => _DepositViewState();
}

class _DepositViewState extends State<DepositView> {
  String _amount = '0';
  String _error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                'GH¢$_amount',
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                _error,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.4,
                  children: setKeyboard(),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _actionBtn('spent'),
                  _actionBtn('saved'),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _numberBtn(String number) {
    return TextButton(
      child: Text(
        number,
        style: TextStyle(
          fontSize: 40,
          color: Theme.of(context).textTheme.bodyText2.color,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        setState(() {
          if (_amount == '0') {
            _amount = number;
          } else if (_amount.length == 7) {
            _amount = _amount;
            HapticFeedback.heavyImpact();
          } else {
            _amount += number;
          }
        });
      },
    );
  }

  Widget _decimalBtn() {
    return TextButton(
      child: Text(
        '.',
        style: TextStyle(
          fontSize: 40,
          color: Theme.of(context).textTheme.bodyText2.color,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        setState(() {
          if (_amount == '0') {
            _amount = '.';
          } else if (_amount.length == 7) {
            _amount = _amount;
            HapticFeedback.heavyImpact();
          } else {
            _amount += '.';
          }
        });
      },
    );
  }

  Widget _deleteBtn() {
    return TextButton(
      child: Text(
        '<',
        style: TextStyle(
          fontSize: 40,
          color: Theme.of(context).textTheme.bodyText2.color,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        setState(() {
          if (_amount.length <= 1) {
            _amount = '0';
          } else {
            _amount = _amount.substring(0, _amount.length - 1);
          }
        });
      },
    );
  }

  Widget _actionBtn(String type) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: RoundedButton(
          color: Theme.of(context).accentColor,
          child: Text(
            type[0].toUpperCase() + type.substring(1),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            actionPressed(type);
          },
        ),
      ),
    );
  }

  Future<void> actionPressed(String type) async {
    if (_amount == '0') {
      setState(() {
        _error = 'Enter an amount';
      });
    } else if (type == 'spent' &&
        double.parse(_amount) >
            (widget.budget.amount -
                (widget.budget.amountUsed + widget.budget.amountSaved))) {
      setState(() {
        _error =
            "This will take you over your allocated budget of GH¢${widget.budget.amount.floor()}\nLimit: GH¢${widget.budget.amount - widget.budget.amountSaved - widget.budget.amountSaved}";
      });
    } else if (type != 'spent' &&
        double.parse(_amount) >
            (widget.budget.amount -
                (widget.budget.amountUsed + widget.budget.amountSaved))) {
      setState(() {
        _error =
            "Insufficient funds Limit: GH¢${widget.budget.amount - widget.budget.amountSaved - widget.budget.amountSaved}";
      });
    } else {
      String uid = MyProvider.of(context).auth.getCurrentUID();
      setState(() {
        _error = '';
        widget.budget.updateLedger(_amount, type);
      });
      showLoadingSnackBar(context);

      await MyProvider.of(context).database.addToLedger(uid, widget.budget);
      await MyProvider.of(context)
          .database
          .updateAmountSaved(uid, widget.budget);
      await MyProvider.of(context)
          .database
          .updateAmountUsed(uid, widget.budget);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              BudgetDetailsView(budget: widget.budget),
          transitionDuration: Duration(seconds: 0),
        ),
      );
    }
  }

  List setKeyboard() {
    List<Widget> keyboard = [];

    // 1 - 9
    List.generate(9, (index) {
      keyboard.add(_numberBtn('${index + 1}'));
    });

    keyboard.add(_decimalBtn());
    keyboard.add(_numberBtn('0'));
    keyboard.add(_deleteBtn());

    return keyboard;
  }
}