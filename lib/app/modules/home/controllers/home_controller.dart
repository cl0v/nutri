import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/repositories/home_repository.dart';
import 'package:nutri/app/modules/home/models/meal_card_model.dart';
import 'package:nutri/app/data/providers/home_provider.dart';
import 'package:nutri/app/routes/app_pages.dart';

// IDEIA: Sugerir as mais importantes(maior PE) ja marcadas

// TODO: Quando chega no ultimo item, nao tem pra onde ir, dar um feedback ou parabenizar a pessoa(pontos concluidos)
// IDEIA: (10/10) Criar um card para o final da lista(Card indicando os pontos da pessoa e talvez um pequeno resuminho)
// Pode ser um card xapado azul da cor do tema, apenas um overview do dia;
//TODO: Na ultima meal, quando confirmada, mostrará as informações na tela

//TODO: Quando a pessoa toca no info do card de cada refeição, explica aquela refeição

// TODO: O widget de extras mostrará apenas imagens com base na quantidade, de 1 a 3

//TODO: Salvar os dados da refeição a medida que o usuário for preenchendo(Para dar feedback no final do dia) (posso usar o shared, porem na ultima do dia, salvar no banco);
//TODO: Resetar o index todo dia(Pode bugar caso a pessoa abra o app apenas uma vez na semana e novamente no mesmo dia Sab-Sab, coincidentemente)

//TODO: Futuramente pegar o horario e definir se ela pulou a refeição com base em horarios

//- Resetar o index todo dia(//TODO:Precisa ser testado)

class HomeController extends GetxController {
  final HomeRepository repository;
  HomeController({required this.repository});

  final mealsOfTheDay = <MealCardModel>[].obs;

  final mealListLenght = 0.obs;

  final isPreviewBtnDisabled = true.obs;
  final isNextBtnDisabled = false.obs;

  final mainFoodsAvailable = <FoodModel>[].obs;
  final extraFoodsAvailable = <FoodModel>[].obs;

  final RxBool _showHomeContent = false.obs;
  bool get showHomeContent => _showHomeContent.value!;

  final showingDayIndex = 0.obs;
  int todayDayIndex = 0;

  int mealIndex = 0;

  final selectedMainFoodIdx = 0.obs;

  final _selectedExtrasList = <int>[].obs;
  List<int> get selectedExtrasList => _selectedExtrasList;

  List<FoodModel> selectedExtras = [];

  final _extrasAmount = 3.obs;
  int get extrasAmount => _extrasAmount.value;

  int indexOfTheDayOnWeek = 0;

  PageController pageController = PageController();

  final mealCategory = 'Café da manhã'.obs;

//IDEIA: Fluxo basico > a home vai enviando dados durante o dia para o provider
// O provider vai salvando
// No final do dia, na ultima refeição, um metodo que te dá o resultado do dia é chamado
// E os parametros basicos sao resetados, meal, day etc

  @override
  void onInit() {
    super.onInit();

    _initHome();
  }

  @override
  void onClose() {
    super.onClose();
    repository.closeHomeStream();
  }

  _initHome() async {
    repository.getHomeState().listen((state) {
      switch (state) {
        case HomeState.Ready:
          _showHomeContent.value = true;
          break;
        case HomeState.SharedPrefsNull:
          Get.offAllNamed(Routes.FOOD_SWIPE);
          break;
        default:
          break;
      }
    });
    await _setDayOfTheWeek();
    mealIndex = await repository.getActualMealPrefs(todayDayIndex);
    _fetchTodayMeals();
  }

  _fetchTodayMeals() async {
    var dailyMeals = await repository.fetchDailyMeals(
        day: DateTime.now().weekday); //FIXME: Erro aq
    if (dailyMeals.isNotEmpty) {
      mealsOfTheDay.assignAll(
          (dailyMeals).map((meal) => MealCardModel(mealModel: meal)));
      _setMeal(mealsOfTheDay[mealIndex].mealModel);
    }
  }

  _setMeal(MealModel meal) async {
    selectedMainFoodIdx.value = 0;
    mainFoodsAvailable.assignAll(meal.mainFoodList);
    extraFoodsAvailable.assignAll(meal.extraList);
    _extrasAmount.value = meal.extraAmount;
    selectedExtras = [];
    _selectedExtrasList.assignAll([]);
    mealCategory.value = MealModelHelper.getTranslatedMeal(meal.mealType);
  }

  _setDayOfTheWeek() {
    showingDayIndex.value = DateTime.now().weekday;
    todayDayIndex = DateTime.now().weekday;
  }

  getSelectedIndex(int idx) => _selectedExtrasList.contains(idx);

  onMainFoodTapped(int idx) => selectedMainFoodIdx.value = idx;

  isMainFoodSelected(int idx) => selectedMainFoodIdx.value == idx;

  onExtraTapped(int idx) {
    if (!_selectedExtrasList.contains(idx) &&
        _selectedExtrasList.length < extrasAmount) {
      _selectedExtrasList.add(idx);
      selectedExtras.add(extraFoodsAvailable[idx]);
      return true;
    } else {
      _selectedExtrasList.remove(idx);
      selectedExtras.remove(extraFoodsAvailable[idx]);
      return false;
    }
  }

  _saveMealOfTheDay() {
    mealsOfTheDay[mealIndex].mealCardState = MealCardState.Done;
    mealsOfTheDay[mealIndex].selectedFood = mealsOfTheDay[mealIndex]
        .mealModel
        .mainFoodList[selectedMainFoodIdx.value];
    mealsOfTheDay[mealIndex].selectedExtras = selectedExtras;
    _buildAndSavePrefs(mealsOfTheDay[mealIndex]);
  }

  _buildAndSavePrefs(MealCardModel mealCard) {
    List<String> prefStringList = [];
    var extrasStringList = mealCard.selectedExtras.map((extra) => extra.title);
    prefStringList.add(mealCard.mealCardState.toString());
    prefStringList.add(mealCard.selectedFood.title);
    prefStringList.addAll(extrasStringList);
    // repository.saveMealPrefs(
    //     mealCard.mealModel.mealType.toString(), prefStringList);
    //TODO: Analizar esse carinha
  }

  onDonePressed() {
    //TODO: Implement onDonePressed
    _saveMealOfTheDay();
    _nextPage();
  }

  onSkippedPressed() {
    //TODO: Implement onSkippedPressed
    _saveMealOfTheDay();
    _nextPage();
  }

  _nextPage() {
    print(mealIndex);
    mealIndex++;
    if (mealIndex >= mealsOfTheDay.length) {
      return _showFinalCard();
    } else {
      repository.setActualMealPrefs(mealIndex, todayDayIndex);
      pageController.nextPage(
        duration: Duration(microseconds: 100),
        curve: Curves.ease,
      );
      _setMeal(mealsOfTheDay[mealIndex].mealModel);
    }
  }

  _showFinalCard() {
    //TODO: Implement: Mostrar o card final
  }

  void onPreviewDayPressed() {
    //TODO: Sempre que solicitar um dia, será o provider quem fornecerá, para nao precisar ficar com tanto espaço na memoria
    //TODO: Implement set meals of the day x;
    showingDayIndex.value--;
    if (indexOfTheDayOnWeek >= 0) {
      isNextBtnDisabled.value = false;
      indexOfTheDayOnWeek--;
    }
    if (indexOfTheDayOnWeek <= 0) {
      isPreviewBtnDisabled.value = true;
    }
  }

  void onNextDayPressed() {
    showingDayIndex.value++;
    if (indexOfTheDayOnWeek <= 6) {
      isPreviewBtnDisabled.value = false;
      indexOfTheDayOnWeek++;
    }
    if (indexOfTheDayOnWeek >= 6) {
      isNextBtnDisabled.value = true;
    }
  }

  String getDayTitle() =>
      HomeScreenHelper.getDayTitle(todayDayIndex, showingDayIndex.value);
}

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
