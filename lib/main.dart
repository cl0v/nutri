import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

// Não colocar apenas as comidas, mas sim os pratos prontos(Assim o usuário nao tem a oportunidade de adicionar um arroz ou feijao)
// Jogar todo o banco de dados atual para extras? (Prato pronto significa por exemplo, proteina com vegetais), no cardzin de extra a pessoa escolha 1 proteina e uns 3 vegetais e alguma bebida por exemplo
// Pegar os exemplos do livro
// Acompanhamentos

//TODO: Melhorar a página SPLASH
//TODO: Adicionar LOGOTIPO
//TODO: Montar página de pagamentos
//TODO: Montar página de FAQ
//TODO: Montar info de cada refeição
//TODO: Sugerir acompanhamentos para preencher o vazio
//TODO: Melhorar o design do app
//TODO: Nao esquecer de mudar a imagem do ovo

//FIXME: Tomate não deve aparecer nas frutas
//FIXME: Corrigir bug do tomate nas frutas
//INFO: Tomate não deverá estar presente nos extras do Card Principal de frutas
//INFO: Tomate deverá estar presente apenas nos extras da segunda refeição de proteinas (o mais perto da refeicao de frutas)

//IDEIA: Card de água seria uma boa para preencher o vazio do café

//IDEIA: Apenas deixar a pessoa escolher o que vai querer pra semana, depois jogar isso pruma todolist de compra
//IDEIA: E sortear aleatoriamente as coisas para fazer o cardapio diario

/* TODO: Criar uma pagina de FAQ para responder possíveis perguntar
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
