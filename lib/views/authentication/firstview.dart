import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:groceries_budget_app/views/authentication/sign_up_view.dart';
import 'package:groceries_budget_app/views/authentication/sign_in_view.dart';

class FirstView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 150),
              dragStartBehavior: DragStartBehavior.down,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Welcome to the Groceries Budget app. Let\'s start saving money now!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: RaisedButton(
                      onPressed: () {
                        Route route = MaterialPageRoute(
                            builder: (context) => SignUpView());
                        Navigator.of(context).push(route);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                      highlightElevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 50,
                          right: 50,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      textColor: Colors.black,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => SignInView());
                            Navigator.of(context).push(route);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          minWidth: 0,
                          padding: EdgeInsets.only(left: 8),
                          textColor: Colors.white,
                        ),
                      ],
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
}
