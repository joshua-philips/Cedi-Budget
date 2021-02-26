import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:groceries_budget_app/services/theme_provider.dart';
import 'package:groceries_budget_app/views/navigation_view.dart';
import 'package:provider/provider.dart';
import 'package:groceries_budget_app/my_provider.dart';
import 'services/auth_service.dart';
import 'views/authentication/firstview.dart';
import 'views/authentication/sign_in_view.dart';
import 'views/authentication/sign_up_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyProvider(
      auth: AuthService(),
      child: ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: Consumer<ThemeNotifier>(
          builder: (context, notifier, child) {
            return MaterialApp(
              title: 'Groceries Budget',
              debugShowCheckedModeBanner: false,
              theme: notifier.darkTheme ? dark : light,
              home: HomeController(),
              routes: <String, WidgetBuilder>{
                '/home': (BuildContext context) => HomeController(),
                '/signUp': (BuildContext context) => SignUpView(),
                '/signIn': (BuildContext context) => SignInView(),
              },
            );
          },
        ),
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: MyProvider.of(context).auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? NavigationView() : FirstView();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
