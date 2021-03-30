import 'package:flutter/material.dart';
import 'package:groceries_budget_app/services/auth_service.dart';
import 'package:groceries_budget_app/widgets/app_bar_home_button.dart';
import 'package:groceries_budget_app/widgets/auth_text_formfield.dart';
import 'package:groceries_budget_app/widgets/rounded_button.dart';
import 'package:groceries_budget_app/widgets/snackbar.dart';
import 'package:groceries_budget_app/widgets/success_alert.dart';

import '../../my_provider.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final formKey = new GlobalKey<FormState>();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        backgroundColor: Theme.of(context).appBarTheme.color,
        actions: [AppBarHomeButton()],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 30,
                    left: 30,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        UpdateTextFormField(
                          controller: _oldPasswordController,
                          helperText: 'Old Password',
                          obscureText: true,
                          validator: (val) {
                            if (val.length < 1) {
                              return 'Please enter old password';
                            } else {
                              return null;
                            }
                          },
                        ),
                        UpdateTextFormField(
                          controller: _newPasswordController,
                          validator: (val) {
                            if (val.length < 6) {
                              return 'New password must have 6 or more characters';
                            } else if (val != _confirmPasswordController.text) {
                              return 'Passwords do not match';
                            } else {
                              return null;
                            }
                          },
                          helperText: 'New Password',
                          obscureText: true,
                        ),
                        UpdateTextFormField(
                          controller: _confirmPasswordController,
                          validator: (val) {
                            if (val.length < 6) {
                              return 'New password must have 6 or more characters';
                            } else if (val != _newPasswordController.text) {
                              return 'Passwords do not match';
                            } else {
                              return null;
                            }
                          },
                          helperText: 'Confirm Password',
                          obscureText: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: RoundedButton(
                            color: Theme.of(context).accentColor,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 50,
                                right: 50,
                                top: 10,
                                bottom: 10,
                              ),
                              child: Text(
                                'Change',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                showLoadingSnackBar(context);
                                String returnedString = await changePassword();
                                if (returnedString == 'Success') {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  successAlertDialog(context, 'Success!',
                                      'Password succesfully changed');
                                  setState(() {
                                    _confirmPasswordController.clear();
                                    _newPasswordController.clear();
                                    _oldPasswordController.clear();
                                  });
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  showMessageSnackBar(context, returnedString);
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

  Future<String> changePassword() async {
    AuthService auth = MyProvider.of(context).auth;
    try {
      await auth.changePassword(
          _oldPasswordController.text, _newPasswordController.text);
      return 'Success';
    } catch (e) {
      print(e);
      return e.message;
    }
  }
}
