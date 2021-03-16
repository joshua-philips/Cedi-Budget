import 'package:flutter/material.dart';
import 'package:groceries_budget_app/lorem.dart';
import 'package:groceries_budget_app/my_provider.dart';

class HelpAndFeedback extends StatefulWidget {
  @override
  _HelpAndFeedbackState createState() => _HelpAndFeedbackState();
}

class _HelpAndFeedbackState extends State<HelpAndFeedback> {
  TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Feedback'),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text('Guidelines'),
            childrenPadding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
            children: [
              Container(
                child: Text(
                  shortLorem,
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Privacy Policy'),
            childrenPadding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
            children: [
              Container(
                child: Text(
                  shortLorem,
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Contributors'),
            childrenPadding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
            children: [
              Row(
                children: [
                  Text(contributors),
                ],
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Feedback'),
            initiallyExpanded: true,
            childrenPadding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                    'Ideas and suggestions to make this app better.\n\nFeedback:'),
              ),
              TextFormField(
                maxLines: 5,
                controller: _feedbackController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).accentColor,
                      width: 2,
                    ),
                  ),
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).accentColor,
                ),
                child: Text('Submit', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  final uid = MyProvider.of(context).auth.getCurrentUID();
                  if (_feedbackController.text.trim().isNotEmpty) {
                    String suggestion = _feedbackController.text;
                    successAlert(context);
                    setState(() {
                      _feedbackController.clear();
                    });
                    await MyProvider.of(context)
                        .database
                        .uploadFeeback(uid, suggestion);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  successAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thank you!'),
        content: Text(
            'Your feedback and suggestions have been sent to the developers. Expect to hear from us soon'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
