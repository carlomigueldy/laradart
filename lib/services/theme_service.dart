import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class ThemeService with ReactiveServiceMixin {
  ThemeService() {
    listenToReactiveValues([_theme]);
  }

  RxValue<ThemeMode> _theme = RxValue<ThemeMode>(initial: ThemeMode.light);
  ThemeMode get theme => _theme.value;
  bool get isDark => _theme.value == ThemeMode.dark;
  bool get isLight => _theme.value == ThemeMode.light;

  /// Toggles the theme [ThemeMode]
  ///
  /// @return void
  void toggleTheme() {
    if (_theme.value == ThemeMode.light) {
      _theme.value = ThemeMode.dark;
    } else {
      _theme.value = ThemeMode.light;
    }
  }

  /// Here we define our theme colors for dark mode
  ThemeData get darkTheme {
    return ThemeData(
      backgroundColor: Colors.grey[900],
      primaryColor: Colors.indigo[400],
      accentColor: Colors.indigo[100],
      fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        color: Colors.grey[850],
        elevation: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.indigo[400],
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0),
        ),
      ),
    );
  }

  /// Here we define our theme colors for dark mode
  ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.indigo[400],
      accentColor: Colors.indigo[100],
      fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      appBarTheme: AppBarTheme(elevation: 0),
      snackBarTheme: SnackBarThemeData(
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.indigo[400],
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
