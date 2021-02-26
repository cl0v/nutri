import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/repositories/meal_repository.dart';
import 'package:nutri/app/modules/home/models/meal_card_model.dart';

// IDEIA: Deslizar os extras pra direita mostra os card de beba agua

// TODO: Quando chega no ultimo item, nao tem pra onde ir, dar um feedback ou parabenizar a pessoa(pontos concluidos)
// IDEIA: (10/10) Criar um card para o final da lista(Card indicando os pontos da pessoa e talvez um pequeno resuminho)
// Pode ser um card xapado azul da cor do tema, apenas um overview do dia;
// IDEIA: (4/10) Add dots indicator (num de refeiçoes do dia) : https://github.com/jlouage/flutter-carousel-pro/blob/master/lib/src/carousel_pro.dart

// IDEIA: (10/10) Preencher os extras restantes com sugestões com base
// no peso (valor que eu atribuo com base na qualidade do alimento)
// e no PE (Valor do livro)
// Para sempre manter na casa dos 9 extras para ter um grid arrumadin

//TODO: Quando a pessoa toca no info do card de cada refeição, explica aquela refeição

// IDEIA: Quando a pessoa confirma uma refeição a frente, a de tras deve ser marcada como nao concluida
// EX: Se eu confirmar o almoço, mas nao ter marcado o cafe da manha, o cafe da manha será marcado como nao concluido
// ... => Posso adicionar uma categoria que seja, nao confirmado, nem skipado... (nao informado)

//TODO: Salvar os dados do usuario (dia de hoje, ontem, etc)
//TODO: [IMPORTANTE] Gerar a lista de refeições da semana apenas uma vez por semana
//TODO: [IMPORTANTE] Salvar a lista de refeiçoes semanal, e sempre carregar ela quando o user entrar

//TODO: Salvar os dados da refeição a medida que o usuário for preenchendo(posso usar o shared, porem na ultima do dia, salvar no banco);


class HomeController extends GetxController {
  final MealRepository repository;

  HomeController({@required this.repository});

  List<List<MealCardModel>> dailyMenuOfTheWeek = [];
  final mealList = <MealCardModel>[].obs;
  final mealListLenght = 0.obs;

  final _extras = <FoodModel>[].obs;
  List<FoodModel> get extras => _extras;

  final isPreviewBtnDisabled = true.obs;
  final isNextBtnDisabled = false.obs;

  ///Armazena o index do atual meal card
  int mealIndex = 0;

  final showingDay = 0.obs;
  int todayDay = 0;

  ///Armazena os extras selecionados do atual meal card
  final _selectedExtrasList = <int>[].obs;
  List<int> get selectedExtrasList => _selectedExtrasList;

  ///Quantidade de extras que deverá ter
  final _extrasAmount = 1.obs;
  int get extrasAmount => _extrasAmount.value;

  int indexOfTheDayOnWeek = 0;

  bool get isToday => indexOfTheDayOnWeek == 0;

  PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    _setDayOfTheWeek();
    // _fetchMeals();
    _fetchWeekDailyMeals();
  }

  _setDayOfTheWeek() {
    showingDay.value = DateTime.now().weekday;
    todayDay = DateTime.now().weekday;
  }

  // _fetchMeals() async {
  //   mealList = ((await repository.fetchDailyMeals())
  //       .map((meal) => MealCardModel(mealModel: meal))
  //       .toList());
  //   _setMeal(mealList);
  // }

  _setMeal(List<MealCardModel> m) {
    pageController.jumpToPage(0);
    mealList.assignAll(m);
    mealListLenght.value = m.length;
    _onMealChanged(0);
  }

  _fetchWeekDailyMeals() async {
    dailyMenuOfTheWeek = (await repository.fetchDailyMenuOfTheWeek())
        .map(
          (dailyMeal) => dailyMeal
              .map(
                (mealModel) => MealCardModel(
                  mealModel: mealModel,
                  extraAmount: mealModel.extraAmount,
                ),
              )
              .toList(),
        )
        .toList();
    _setMeal(dailyMenuOfTheWeek[indexOfTheDayOnWeek]);
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
    _extrasAmount.value = mealList[idx].extraAmount;
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

  void onPreviewDayPressed() {
    showingDay.value--;
    if (indexOfTheDayOnWeek >= 0) {
      isNextBtnDisabled.value = false;
      indexOfTheDayOnWeek--;
      _setMeal(dailyMenuOfTheWeek[indexOfTheDayOnWeek]);
    }
    if (indexOfTheDayOnWeek <= 0) {
      isPreviewBtnDisabled.value = true;
    }
  }

  String getDayTitle() =>
      HomeScreenHelper.getDayTitle(todayDay, showingDay.value);

  void onNextDayPressed() {
    showingDay.value++;
    if (indexOfTheDayOnWeek <= 6) {
      isPreviewBtnDisabled.value = false;
      indexOfTheDayOnWeek++;
      _setMeal(dailyMenuOfTheWeek[indexOfTheDayOnWeek]);
    }
    if (indexOfTheDayOnWeek >= 6) {
      //Vai bugar pq vai desativar o botao no 1 a mais, vou precisar apertar duas vz o outro pra voltar
      isNextBtnDisabled.value = true;
    }

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
