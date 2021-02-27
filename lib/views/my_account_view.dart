import 'package:flutter/material.dart';
import 'package:groceries_budget_app/my_provider.dart';
import 'package:groceries_budget_app/services/auth_service.dart';

import 'update_user_info_view.dart';

class MyAccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = MyProvider.of(context).auth;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('My Account'),
            floating: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SafeArea(
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            displayUserInformation(context, auth),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Center(
                                child: FlatButton(
                                  child: Text(
                                    'Update Account Info',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  minWidth: 0,
                                  padding: EdgeInsets.only(left: 8),
                                  onPressed: () {
                                    Route route = MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateUserInfoView(),
                                    );
                                    Navigator.push(context, route);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget displayUserInformation(context, AuthService auth) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          displayImage(auth, context),
          SizedBox(height: 10),
          displayName(auth),
          SizedBox(height: 10),
          Text(
            auth.getCurrentUser().email,
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          displayPhoneNumber(auth),
        ],
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
      return Text('Phone number not available');
    }
  }

  Widget displayImage(AuthService auth, context) {
    if (auth.getProfileImageUrl() != null) {
      return CircleAvatar(
        radius: 70,
        backgroundColor: Theme.of(context).primaryColor,
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
