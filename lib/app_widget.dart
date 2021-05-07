import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/routes/app_pages.dart';
import 'package:nutri/app_theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onGenerateTitle: (ctx) => 'Nutricionista Virtual',
      title: "Nutri Nest (Nutricionista Virtual)",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme().appTheme(),
      debugShowCheckedModeBanner: false,
      enableLog: false,
      
    );
  }
}