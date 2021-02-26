import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/repositories/meal_repository.dart';
import 'package:nutri/app/modules/home/models/meal_card_model.dart';

// IDEIA: Quando a pessoa nao tem extras ou terminou as refeicoes do dia, mostra os card de agua??
// IDEIA: Deslizar os extras pra direita mostra os card de beba agua

// TODO: Quando chega no ultimo item, nao tem pra onde ir, dar um feedback ou parabenizar a pessoa(pontos concluidos)
// IDEIA: Criar um card para o final da lista(Card indicando os pontos da pessoa e talvez um pequeno resuminho)
// IDEIA: Pode ser um card xapado azul da cor do tema, apenas um overview do dia;
// IDEIA: Depois que o user conclui a ultima refeição, dar a possibilidade de ver o que vai comer amanha (desativar os botoes de concluir e pular... Deixar apenas o trocar)
// IDEIA: Add dots indicator (num de refeiçoes do dia) : https://github.com/jlouage/flutter-carousel-pro/blob/master/lib/src/carousel_pro.dart

// TODO: IMPORTANTE: Definir a quantidade de acompanhamentos que podem ser selecionados(inicialmente 3 [extrasAmount])
// TODO: Adicionar variavel que diz se tem extras disponiveis, caso nao tenha, nao aparece o texto 'Selecione x extras'

// IDEIA: COOL: Preencher os extras restantes com sugestões com base
// no peso (valor que eu atribuo com base na qualidade do alimento)
// e no PE (Valor do livro)
// Para sempre manter na casa dos 9 extras para ter um grid arrumadin

// FIXME: Quando a pessoa confirma uma refeição a frente, a de tras deve ser marcada como nao concluida
// EX: Se eu confirmar o almoço, mas nao ter marcado o cafe da manha, o cafe da manha será marcado como nao concluido
// Posso adicionar uma categoria que seja, nao confirmado, nem skipado... (nao informado)

// FIXME: Corrigir o botão de dia anterior e dia seguinte
// Por enquanto com base na lista semanal(logo calcula o hoje e amanha em diante)

class HomeController extends GetxController {
  final MealRepository repository;

  HomeController({@required this.repository});

  List<MealCardModel> mealList = <MealCardModel>[];
  final mealListLenght = 0.obs;

  final _extras = <FoodModel>[].obs;
  List<FoodModel> get extras => _extras;

  final isPreviewBtnDisabled = false.obs;
  final isNextBtnDisabled = false.obs;

  ///Armazena o index do atual meal card
  int mealIndex = 0;

  final showingDay = 0.obs;
  int todayDay = 0;

  ///Armazena os extras selecionados do atual meal card
  final _selectedExtrasList = <int>[].obs;
  List<int> get selectedExtrasList => _selectedExtrasList;

  ///Quantidade de extras que deverá ter
  final _extrasAmount = 3.obs;
  int get extrasAmount => _extrasAmount.value;

  PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    _setDayOfTheWeek();
    _fetchMeals();
  }

  _setDayOfTheWeek() {
    showingDay.value = DateTime.now().weekday;
    todayDay = DateTime.now().weekday;
  }

  onPageChanged(int idx) {
    _saveExtrasSelectedIndex();
    lockedAnswer = false;
    mealIndex = idx;
    _onMealChanged(idx);
  }

  _onMealChanged(int idx) {
    _setExtras(idx);
  }

  _setExtras(int idx) {
    _selectedExtrasList.assignAll(mealList[idx].extrasSelectedIndex);
    _extras.assignAll(mealList[idx].mealModel.extras);
  }

  _saveExtrasSelectedIndex() {
    mealList[mealIndex].extrasSelectedIndex = _selectedExtrasList.toList();
    _selectedExtrasList.clear();
  }

  getSelectedIndex(int idx) => _selectedExtrasList.contains(idx);

  onExtraTapped(int idx) {
    if (mealList[mealIndex].mealCardState == MealCardState.None)
      !_selectedExtrasList.contains(idx) &&
              _selectedExtrasList.length < extrasAmount
          ? _selectedExtrasList.add(idx)
          : _selectedExtrasList.remove(idx);
  }

  bool lockedAnswer = false;

  onDonePressed(int idx) {
    if (lockedAnswer) return;
    lockedAnswer = true;
    mealList[idx].mealCardState = MealCardState.Done;
    _nextMeal(idx);
  }

  onSkipPressed(int idx) {
    if (lockedAnswer) return;
    lockedAnswer = true;
    mealList[idx].mealCardState = MealCardState.Skiped;
    _nextMeal(idx);
  }

  _nextMeal(int idx) {
    if (idx >= mealListLenght.value - 1) {
      pageController.jumpToPage(0);
    } else
      pageController.nextPage(
          duration: Duration(milliseconds: 1), curve: Curves.linear);
  }

  

  _fetchMeals() async {
    mealList = ((await repository.fetchDailyMeals())
        .map((meal) => MealCardModel(mealModel: meal))
        .toList());
    mealListLenght.value = mealList.length;
    _onMealChanged(0);
  }

  void onPreviewDayPressed() {
    showingDay.value--;
    //TODO: Implement onPreviewDayPressed
  }

  String getDayTitle() =>
      HomeScreenHelper.getDayTitle(todayDay, showingDay.value);

  void onNextDayPressed() {
    showingDay.value++;
    //TODO: Implement onNextDayPressed
  }
}

//Bug no domingo...
//IMplementar hoje, amanha e ontem
abstract class HomeScreenHelper {
  static dayOnTheWeekToString(int dayNum) {
    if (dayNum > 7) {
      dayNum = (dayNum % 7);
    } else if (dayNum < 1) {
      dayNum = (dayNum % 7);
    }
    if (dayNum == 0) dayNum = 7;

    return dayNum;
  }

  static getDayTitle(int today, int showingDay) {
    if (showingDay == today + 1) {
      return 'AMANHÃ';
    } else if (showingDay == today - 1) {
      return 'ONTEM';
    } else if (showingDay == today) {
      return 'HOJE';
    } else
      return getDayOfTheWeekString(dayOnTheWeekToString(showingDay));
  }

//TODO: Corrigir bug do domingo (dia > 8 ou dia 0 <)
  static String getDayOfTheWeekString(int day) {
    switch (day) {
      case 1:
        return 'SEGUNDA';
      case 2:
        return 'TERÇA';
      case 3:
        return 'QUARTA';
      case 4:
        return 'QUINTA';
      case 5:
        return 'SEXTA';
      case 6:
        return 'SÁBADO';
      case 7:
        return 'DOMINGO';
      default:
        return 'HOJE';
    }
  }
}
