import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

/*
TODO: --- Sugestoes bacanas ---
-> Apenas deixar a pessoa escolher o que vai querer pra semana, depois jogar isso pruma dotolist de compra
-> E sortear aleatoriamente as coisas para fazer o cardapio diario


-----------========----------========-------------========-------------


-> Definir que tipo de alimento combina com qual tipo de combinaçao
-> Definir que tipo de alimento deve ser sugerido
*/


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

  buttonTheme: ButtonThemeData(
    buttonColor: Color.fromRGBO(244, 208, 120, 1),
    colorScheme: ColorScheme.dark(),
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(9.0),
    ),
    //   textTheme: ButtonTextTheme.primary,
  ),
);