import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nutri/constants.dart';
import 'app/routes/app_pages.dart';

//FIXME: Pulando a splash

//Definir o fluxo do app
//Da pagina de login irá para a homePage em formato de carregamento
//Caso não tenha sido escolhido foodswipe essa semana, mostrar a página de foodswipe
//A home irá decidir quais dados estão marcados, pois tem o questions e o foodswipe que são necessários
//antes da home, logo a home decidirá se vai ter que voltar ou não
//Talvez buscar o estado, pois o cliente pode não responder o quesitonario e fechar o app na pressa
// e dpois logar

//IDEIA: Não colocar apenas as comidas, mas sim os pratos prontos(Assim o usuário nao tem a oportunidade de adicionar um arroz ou feijao)
// Pegar os exemplos do livro

//TODO: Imagem de fundo(Posso procurar uma cor de fundo melhor)
//TODO: Logotipo
//TODO: Melhorar a página SPLASH
//TODO: Montar página de pagamentos
//TODO: Montar página de FAQ
//TODO: Montar info de cada refeição(?)
//TODO: Sugerir acompanhamentos para preencher o vazio(?)
//TODO: Melhorar o design do app

//IDEIA: Card de água seria uma boa para preencher o vazio do café

//IDEIA: Apenas deixar a pessoa escolher o que vai querer pra semana, depois jogar isso pruma todolist de compra

/* TODO: Criar uma pagina de FAQ para responder possíveis perguntas
 - Por que não estou sentindo o gosto de sal na comida, devo comer mais sal?
 - Posso comer doces?
 - Posso comer o que não está no cardápio?
 - Qual quantidade devo comer?
 - Estou sentindo muita fome, o que faço? - Repete a refeição anterior, pode exagerar na quantidade(sem limite)
 - Descobrir quantas refeições a pessoa costuma fazer
*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      GetMaterialApp(
        onGenerateTitle: (ctx)=>'Nutricionista Virtual',
        title: "Nutri Nest (Nutricionista Virtual)",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: newTheme,
        debugShowCheckedModeBanner: false,
        enableLog: false,
      ),
    ),
  );
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
