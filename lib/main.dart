import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutri/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(MyApp()),
  );
}

//TODO: Buildar o app com bate na refeição do livro, depois ir atualizando
// Remover o foodswipe temporariamente

//FIXME: Pulando a splash

// IDEIA: Sugerir as mais importantes(maior PE) ja marcadas

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

//IDEIA: Mostrar pagina de review de dias anteriores

//IDEIA: Quando o user termina as refeições do dia ele vai pra a review page
// Na review page voce pode dar um overview no proximo dia, o botao irá alterar para ser, 'ver review de hoje'

//IDEIA: Futuramente pegar o horario e definir se ela pulou a refeição com base em horarios

// TODO: Quando chega no ultimo item, nao tem pra onde ir, dar um feedback ou parabenizar a pessoa(pontos concluidos)
// IDEIA: (10/10) Criar um card para o final da lista(Card indicando os pontos da pessoa e talvez um pequeno resuminho)
// Pode ser um card xapado azul da cor do tema, apenas um overview do dia;
//TODO: Na ultima meal, quando confirmada, mostrará as informações na tela

//IDEIA: Quando a pessoa toca no info do card de cada refeição, explica aquela refeição

//IDEIA: O widget de extras mostrará apenas imagens com base na quantidade, de 1 a 3

//TODO: Salvar os dados da refeição a medida que o usuário for preenchendo(Para dar feedback no final do dia)
//SOLUTION: (posso usar o shared, porem na ultima do dia, salvar no banco);

//TODO: Resetar o index todo dia(Pode bugar caso a pessoa abra o app apenas uma vez na semana e novamente no mesmo dia Sab-Sab, coincidentemente)

//IDEIA: Apenas deixar a pessoa escolher o que vai querer pra semana, depois jogar isso pruma todolist de compra

/* TODO: Criar uma pagina de FAQ para responder possíveis perguntas
 - Por que não estou sentindo o gosto de sal na comida, devo comer mais sal?
 - Posso comer doces?
 - Posso comer o que não está no cardápio?
 - Qual quantidade devo comer?
 - Estou sentindo muita fome, o que faço? - Repete a refeição anterior, pode exagerar na quantidade(sem limite)
 - Descobrir quantas refeições a pessoa costuma fazer
*/


//BUG:? Quando termino de escolher as comidas do foodswipe apos criar uma conta,
// ela ja vem com as comidas salvas antes de criar a conta
//SOLUTION: Salvar como mapa com o nome do user user/foodprefs


//TODO: Receber o dia que foi buildado as refeições semanais
// - Salva o dia da semana e a semana do ano, se tiver no mesmo dia na semana seuginte, mostra o food swipe
//O dia máximo que o user pode olhar é até 6 dias incluindo o dia do build;(Ou 7, começando de amanha??)
//O user pode olhar os dias anteriores, até no maximo o dia que foi buildado
// Ex, se eu buildei na segunda, só posso olhar até segunda que vem(ou dom da msm semana, sendo a segunda tb um dos dias do build da semana)
// Entao obrigar a pessoa a escolher novamente o foodswipe na segunda que vem

