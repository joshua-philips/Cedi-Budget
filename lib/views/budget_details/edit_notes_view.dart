import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/views/budget_details/budget_details_view.dart';
import 'package:groceries_budget_app/widgets/snackbar.dart';

import '../../my_provider.dart';

class EditNotesView extends StatefulWidget {
  final Budget budget;

  const EditNotesView({Key key, this.budget}) : super(key: key);
  @override
  _EditNotesViewState createState() => _EditNotesViewState();
}

class _EditNotesViewState extends State<EditNotesView> {
  final TextEditingController _notesController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _notesController.text =
        widget.budget.notes != null ? widget.budget.notes : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                buildHeading(context),
                buildNotesText(),
                buildSubmitButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeading(context) {
    // Using Material to prevent problems with the Hero transition
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Edit Budget Notes',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          FlatButton(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).iconTheme.color,
                  width: 2,
                ),
              ),
              child: Icon(Icons.close, size: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget buildNotesText() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        maxLines: null,
        controller: _notesController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        autofocus: true,
      ),
    );
  }

  Widget buildSubmitButton(context) {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          top: 10,
          bottom: 10,
        ),
        child: Text(
          'Save',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      textColor: Colors.white,
      color: Theme.of(context).accentColor,
      onPressed: () async {
        showLoadingSnackBar(_scaffoldKey);
        widget.budget.notes = _notesController.text;

        final uid = MyProvider.of(context).auth.getCurrentUID();
        try {
          await MyProvider.of(context)
              .database
              .updateNotes(uid, _notesController.text.trim(), widget.budget);
          _scaffoldKey.currentState.hideCurrentSnackBar();
        } catch (e) {
          print(e.message);
          _scaffoldKey.currentState.hideCurrentSnackBar();
          showMessageSnackBar(_scaffoldKey, e.message);
        }
        Route route = MaterialPageRoute(
          builder: (context) => BudgetDetailsView(
            budget: widget.budget,
          ),
        );
        // Pop twice and then push the Detail Trip View to refresh
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.push(context, route);
      },
    );
  }
}
