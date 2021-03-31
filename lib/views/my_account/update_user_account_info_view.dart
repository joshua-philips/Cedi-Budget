import 'package:flutter/material.dart';
import 'package:groceries_budget_app/my_provider.dart';
import 'package:groceries_budget_app/services/auth_service.dart';
import 'package:groceries_budget_app/views/my_account/my_account_view.dart';
import 'package:groceries_budget_app/widgets/app_bar_home_button.dart';
import 'package:groceries_budget_app/widgets/auth_text_formfield.dart';
import 'package:groceries_budget_app/widgets/snackbar_and_loading.dart';
import 'package:groceries_budget_app/widgets/rounded_button.dart';

class UpdateUserAccountInfoView extends StatefulWidget {
  @override
  _UpdateUserAccountInfoViewState createState() =>
      _UpdateUserAccountInfoViewState();
}

class _UpdateUserAccountInfoViewState extends State<UpdateUserAccountInfoView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
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
                          validator: (val) {
                            if (val.length < 2) {
                              return 'Name must have 2+ characters';
                            } else {
                              return null;
                            }
                          },
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
                                showLoadingDialog(context);
                                String returnedString = await changeUserInfo();
                                hideLoadingDialog(context);

                                if (returnedString == 'Success') {
                                  showMessageSnackBar(
                                      context, 'User info updated');
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
      await auth.updateUserInfo(_nameController.text);
      return 'Success';
    } catch (e) {
      print(e);
      return e.message;
    }
  }
}
