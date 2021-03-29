import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.red,
  primaryColor: Colors.grey[200],
  accentColor: Colors.redAccent,
  scaffoldBackgroundColor: Colors.grey[200],
  textTheme: GoogleFonts.quicksandTextTheme(
    TextTheme(
      bodyText2: TextStyle(color: Colors.black),
    ),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.grey[200],
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    textTheme: GoogleFonts.quicksandTextTheme(
      TextTheme(
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
  ),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  cardTheme: CardTheme(
    elevation: 0.5,
  ),
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.red,
  accentColor: Colors.redAccent,
  textTheme: GoogleFonts.quicksandTextTheme(
    TextTheme(
      bodyText2: TextStyle(color: Colors.white),
    ),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    textTheme: GoogleFonts.quicksandTextTheme(
      TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
);

class ThemeNotifier extends ChangeNotifier {
  final String key = 'theme';
  SharedPreferences _pref;
  bool _darkTheme;
  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = true;
    _loadFromPrefs();
  }

  // toggle theme: if false change to true, if true change to false
  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  /// Inititalize the _pref value
  _initPrefs() async {
    if (_pref == null) {
      _pref = await SharedPreferences.getInstance();
    }
  }

  /// Get theme from SharedPreferences
  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _pref.getBool(key) ?? true;
    notifyListeners();
  }

  /// Save theme to SharedPreferences
  _saveToPrefs() async {
    await _initPrefs();
    _pref.setBool(key, _darkTheme);
  }
}
