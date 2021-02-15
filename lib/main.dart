import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      GetMaterialApp(
        title: "Nutri Nest (Nutricionista Virtual)",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: theme,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

var theme = ThemeData(
  // brightness: Brightness.dark,

  accentColor: Color.fromRGBO(244, 208, 120, 1),
  textTheme:
      TextTheme(button: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  scaffoldBackgroundColor: Colors.white,
  // appBarTheme: AppBarTheme(
  //   color: Colors.white,
  //   elevation: 0,
  // ),

  buttonTheme: ButtonThemeData(
    buttonColor: Color.fromRGBO(244, 208, 120, 1),
    colorScheme: ColorScheme.dark(),

    //   textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(9.0),
    ),
  ),
);
