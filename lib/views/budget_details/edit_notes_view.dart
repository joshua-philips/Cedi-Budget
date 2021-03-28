import 'package:flutter/material.dart';
import 'package:groceries_budget_app/models/budget.dart';
import 'package:groceries_budget_app/views/budget_details/budget_details_view.dart';
import 'package:groceries_budget_app/widgets/snackbar.dart';
import 'package:groceries_budget_app/widgets/rounded_button.dart';

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
          TextButton(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).iconTheme.color,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.close,
                size: 20,
                color: Theme.of(context).iconTheme.color,
              ),
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
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).accentColor,
              width: 2,
            ),
          ),
        ),
        autofocus: true,
        textCapitalization: TextCapitalization.sentences,
      ),
    );
  }

  Widget buildSubmitButton(context) {
    return RoundedButton(
      color: Theme.of(context).accentColor,
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
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      onPressed: () async {
        showLoadingSnackBar(context);
        widget.budget.notes = _notesController.text;

        final uid = MyProvider.of(context).auth.getCurrentUID();
        try {
          await MyProvider.of(context)
              .database
              .updateNotes(uid, _notesController.text.trim(), widget.budget);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        } catch (e) {
          print(e.message);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showMessageSnackBar(context, e.message);
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
