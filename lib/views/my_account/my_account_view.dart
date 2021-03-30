import 'package:flutter/material.dart';
import 'package:groceries_budget_app/my_provider.dart';
import 'package:groceries_budget_app/services/auth_service.dart';
import 'package:intl/intl.dart';
import 'package:groceries_budget_app/widgets/rounded_button.dart';

import '../my_account/update_user_account_info_view.dart';

class MyAccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = MyProvider.of(context).auth;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  displayUserInformation(context, auth),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      Route route = MaterialPageRoute(
                        builder: (context) => UpdateUserAccountInfoView(),
                      );
                      Navigator.push(context, route);
                    },
                    icon: Icon(Icons.account_circle),
                    label: Text(
                      'Update Account Info',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),
                  RoundedButton(
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        await auth.signOut();
                      } catch (e) {
                        print(e);
                      }
                      Navigator.pop(context);
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

  Widget displayUserInformation(context, AuthService auth) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          displayImage(auth, context),
          SizedBox(height: 10),
          displayName(auth),
          SizedBox(height: 10),
          displayEmail(auth),
          SizedBox(height: 10),
          displayPhoneNumber(auth),
          SizedBox(height: 5),
          displayDateCreated(auth, context),
        ],
      ),
    );
  }

  Widget displayEmail(AuthService auth) {
    return Text(
      auth.getCurrentUser().email,
      style: TextStyle(fontSize: 20),
    );
  }

  Widget displayDateCreated(AuthService auth, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.17,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('member since'),
            SizedBox(height: 10),
            Text(
              '${DateFormat('EEE, MMM dd, yyyy').format(auth.getCurrentUser().metadata.creationTime)}',
              style: TextStyle(fontSize: 35),
            ),
          ],
        ),
      ),
    );
  }

  Widget displayName(AuthService auth) {
    if (auth.getCurrentUser().displayName != null) {
      return Text(
        auth.getCurrentUser().displayName,
        style: TextStyle(fontSize: 20),
      );
    } else {
      return Container();
    }
  }

  Widget displayPhoneNumber(AuthService auth) {
    if (auth.getCurrentUser().phoneNumber != null) {
      return Text(auth.getCurrentUser().phoneNumber);
    } else {
      return Text('');
    }
  }

  Widget displayImage(AuthService auth, context) {
    if (auth.getProfileImageUrl() != null) {
      return CircleAvatar(
        radius: 70,
        backgroundColor: Theme.of(context).accentColor,
        backgroundImage: NetworkImage(
          auth.getProfileImageUrl(),
        ),
      );
    } else {
      return Icon(
        Icons.account_circle,
        size: 150,
      );
    }
  }
}
