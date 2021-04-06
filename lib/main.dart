import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutri/app_widget.dart';

//TODO: Adicionar sexo da pessoa, masculino ou feminino
//BUG: Quando a pessoa nao incia o dia, mas ja olha as refeições de dias seguintes, fica aparecendo o botao de comecar, deveria ser ver hoje
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(MyApp()),
  );
}

//IDEIA: Mostrar pagina de review de dias anteriores
//Página de historico (Provavelmente uma opção da página de perfil por enquanto)

//IDEIA: Criar Lista de compras semanal(Provavelmente uma opção da página de perfil por enquanto)

/* TODO: Criar uma pagina de FAQ para responder possíveis perguntas (Provavelmente uma opção da página de perfil por enquanto)
 - Por que não estou sentindo o gosto de sal na comida, devo comer mais sal?
 - Posso comer doces?
 - Posso comer o que não está no cardápio?
 - Qual quantidade devo comer?
 - Estou sentindo muita fome, o que faço? - Repete a refeição anterior, pode exagerar na quantidade(sem limite)
 - Descobrir quantas refeições a pessoa costuma fazer
*/
