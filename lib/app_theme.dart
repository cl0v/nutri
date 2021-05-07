import 'package:flutter/material.dart';
import 'package:nutri/constants.dart';

class AppTheme {
  appTheme() {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(99.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(99.0),
          borderSide: BorderSide(
            color: Colors.green,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(99.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(99.0),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
      ),
      brightness: kBrightness,
      scaffoldBackgroundColor: kScaffoldBackgroundColor,
      backgroundColor: kBackgroundColor,
      primaryColorBrightness: kBrightness,
      accentColorBrightness: kBrightness,
      textTheme: kTextTheme,
      primarySwatch: kPrimarySwatch,
      primaryColor: kPrimaryColor,
      accentColor: kAccentColor,
    );
  }
}
