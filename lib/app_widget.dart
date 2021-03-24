

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/routes/app_pages.dart';
import 'package:nutri/constants.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
GetMaterialApp(
        onGenerateTitle: (ctx)=>'Nutricionista Virtual',
        title: "Nutri Nest (Nutricionista Virtual)",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: newTheme,
        debugShowCheckedModeBanner: false,
        enableLog: false,
      );
  }
}

var newTheme = ThemeData(
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
  // textButtonTheme: ,

  primaryColorBrightness: kBrightness,
  accentColorBrightness: kBrightness,
  textTheme: kTextTheme,
  primarySwatch: kPrimarySwatch,
  scaffoldBackgroundColor: kScaffoldBackgroundColor,
  primaryColor: kPrimaryColor,
  accentColor: kAccentColor,
  backgroundColor: kBackgroundColor,
);
