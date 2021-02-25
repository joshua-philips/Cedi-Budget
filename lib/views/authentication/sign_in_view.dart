import 'package:flutter/material.dart';
import 'package:groceries_budget_app/widgets/auth_text_formfield.dart';
import 'package:groceries_budget_app/services/auth_service.dart';
import 'package:groceries_budget_app/my_provider.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final formKey = new GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.red[900],
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        elevation: 0,
        bottomOpacity: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.red[900],
        child: Padding(
          padding: const EdgeInsets.only(right: 30, left: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Log in to your account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 80,
                    right: 10,
                    left: 10,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        AuthTextFormField(
                          controller: _emailController,
                          validator: (val) =>
                              !val.contains('@') ? 'Invalid Email' : null,
                          hintText: 'Email',
                        ),
                        AuthTextFormField(
                          controller: _passwordController,
                          validator: (val) =>
                              val.length < 6 ? '6 or more characters' : null,
                          hintText: 'Password',
                          obscureText: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: RaisedButton(
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
                                'Login',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            textColor: Colors.black,
                            color: Colors.white,
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                print('clicked');
                                showLoadingSnackBar(_scaffoldKey);
                                String returnedString = await signIn();
                                if (returnedString != 'Success') {
                                  showErrorSnackBar(
                                      _scaffoldKey, returnedString);
                                } else {
                                  Navigator.popUntil(context,
                                      (_) => !Navigator.canPop(context));
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home');
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showLoadingSnackBar(GlobalKey<ScaffoldState> scaffoldKey) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: CircularProgressIndicator( // TODO:Use Spinkit Instead
            strokeWidth: 10,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  void showErrorSnackBar(GlobalKey<ScaffoldState> scaffoldKey, String error) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        error,
        style: TextStyle(color: Colors.white),
      ),
    ));
  }

  Future<String> signIn() async {
    final AuthService auth = MyProvider.of(context).auth;

    try {
      await auth.signInWithEmailAndPassword(
          _emailController.text.trim(), _passwordController.text);

      return 'Success';
    } catch (e) {
      print(e.message);
      return e.message.toString();
    }
  }
}
