import 'package:flutter/material.dart';
import 'package:groceries_budget_app/my_provider.dart';
import 'package:groceries_budget_app/services/auth_service.dart';
import 'package:groceries_budget_app/views/my_account/my_account_view.dart';
import 'package:groceries_budget_app/widgets/app_bar_home_button.dart';
import 'package:groceries_budget_app/widgets/snackbar.dart';
import 'package:groceries_budget_app/widgets/rounded_button.dart';

class UpdateUserAccountInfoView extends StatefulWidget {
  @override
  _UpdateUserAccountInfoViewState createState() =>
      _UpdateUserAccountInfoViewState();
}

class _UpdateUserAccountInfoViewState extends State<UpdateUserAccountInfoView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = AuthService().getCurrentUser().displayName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Update My Account'),
        backgroundColor: Theme.of(context).appBarTheme.color,
        actions: [AppBarHomeButton()],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
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
                          controller: _nameController,
                          helperText: 'Name',
                        ),
                        UpdateTextFormField(
                          controller: _newPasswordController,
                          validator: (val) {
                            if (val.length < 6) {
                              return 'Password must have 6 or more characters';
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
                              return 'Password must have 6 or more characters';
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
                            color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 50,
                                right: 50,
                                top: 10,
                                bottom: 10,
                              ),
                              child: Text(
                                'Update',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState.validate()) {
                                print('clicked');
                                showLoadingSnackBar(context);
                                String returnedString = await changeUserInfo();
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();

                                if (returnedString == 'Success') {
                                  showMessageSnackBar(context, returnedString);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MyAccountView(),
                                    ),
                                  );
                                } else {
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

  Future<String> changeUserInfo() async {
    AuthService auth = MyProvider.of(context).auth;
    try {
      await auth.updateUserInfo(
          _nameController.text, _newPasswordController.text);
      return 'Success';
    } catch (e) {
      print(e);
      return e.message;
    }
  }
}

class UpdateTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String helperText;
  final String label;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final bool autofocus;

  UpdateTextFormField({
    @required this.controller,
    this.validator,
    this.helperText,
    this.obscureText,
    this.autofocus,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        controller: controller,
        cursorColor: Colors.redAccent,
        autofocus: autofocus != null ? autofocus : false,
        obscureText: obscureText != null ? obscureText : false,
        decoration: InputDecoration(
          helperText: helperText ?? '',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
