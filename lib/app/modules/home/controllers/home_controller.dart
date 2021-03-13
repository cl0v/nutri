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

//TODO: Pagina inicial mostrando um overview das refeições que a pessoa vai comer no dia
//Esse overview é exatamente igual as paginas do livro, so que em formato de lista

//TODO: Salvar os dados da refeição a medida que o usuário for preenchendo(Para dar feedback no final do dia) (posso usar o shared, porem na ultima do dia, salvar no banco);
//TODO: Resetar o index todo dia(Pode bugar caso a pessoa abra o app apenas uma vez na semana e novamente no mesmo dia Sab-Sab, coincidentemente)

//TODO: Futuramente pegar o horario e definir se ela pulou a refeição com base em horarios

//- Resetar o index todo dia(//TODO:Precisa ser testado)

//TODO: Quando o user termina as refeições do dia ele vai pra a review page
// Na review page voce pode dar um overview no proximo dia, o botao irá alterar para ser, 'ver review de hoje'

enum HomeBodyState {
  Loading, //TODO: Trabalhar com o loading
  Overview,
  Meals,
  Review,
  OtherDayOverview,
}

class HomeController extends GetxController {
  final HomeRepository repository;
  HomeController({required this.repository});

  final mealsOfTheDay = <MealCardModel>[].obs;

  var lastHomeBodyState = HomeBodyState.OtherDayOverview;

  final mealListLenght = 0.obs;

  final isPreviewBtnDisabled =
      true.obs; //TODO: Mostrar pagina de review de dias anteriores
  final isNextBtnDisabled =
      false.obs; //TODO: Mostrar pagina de overview de dias seguintes

  final mainFoodsAvailable = <FoodModel>[].obs;
  final extraFoodsAvailable = <FoodModel>[].obs;

  final RxBool _showHomeContent = false.obs;
  bool get showHomeContent => _showHomeContent.value!;

  final dayIndex = 0.obs;
  int todayIndex = 0;

  int mealIndex = 0;

  final selectedMainFoodIdx = 0.obs;

  final _selectedExtrasList = <int>[].obs;
  List<int> get selectedExtrasList => _selectedExtrasList;

  List<Map<String, String>> overViewMeals = [];
  List<Map<String, String>> overViewMealsOfOtherDay = [];

  List<FoodModel> selectedExtras = [];

  final _extrasAmount = 3.obs;
  int get extrasAmount => _extrasAmount.value;

  final mealCategory = 'Café da manhã'.obs;

  Rx<HomeBodyState> _homeBodyState = HomeBodyState.Loading.obs;
  HomeBodyState get homeBodyState => _homeBodyState.value!;

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _initHome();
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
    _fetchPageIndex(0);
    // _fetchPageIndex(await repository.getPageIndex(todayIndex));
  }

  _fetchPageIndex(int idx) async {
    pageController = PageController(initialPage: idx);
    await _fetchTodayMeals(); //TODO: Trocar a hora em que o home decide se mostra ou nao HomeState.Ready
    _setHomeCardState(idx);
  }

  _savePageIndex(int idx) {
    repository.setPageIndex(idx, todayIndex);
  }

  onPageChanged(int idx) async {
    print(idx);
    _setHomeCardState(idx);
    _savePageIndex(idx);
    //TODO: Passar as responsabilidades de [_nextPage()] para cá

    //TODO: Estudar se esse cara deve ficar aqui
    //Ta bugado a refeição que deve aparecer depois de abrir o app novamente
    //O bug é que o index da page é inicializado novamente, logo, quando o lanche da tarde completa e vai pra janta(se começar no lanche), a proxima refeição vira index 1 e aparece o café da manha
  }

  onDonePressed() {
    //TODO: Implement onDonePressed
    _nextPage(); //TODO: NextPage pode se tornar nextMeal, facilitando a decisao
  }

  onSkippedPressed() {
    //TODO: Implement onSkippedPressed

    _nextPage();
  }

  _nextPage() {
    pageController.nextPage(
      duration: Duration(microseconds: 100),
      curve: Curves.ease,
    );
  }

  ///Responsável por monitorar o estado da home para cada troca de página
  _setHomeCardState(int idx) async {
    switch (idx) {
      case 0:
        _homeBodyState.value = HomeBodyState.Overview;
        break;
      case 5:
        _homeBodyState.value = HomeBodyState.Review;
        break;
      default:
        _homeBodyState.value = HomeBodyState.Meals;
        _setMeal(idx - 1);
        break;
    }
  }

//TODO: Posso receber o pgIndex para saber se está na overview ou na review
// Caso seja diferente de 0, atribui o valor ao mealIndex(1-4),
// 0 - OverView
// 1-4 - Meal
// 5 - Review

  @override
  void onClose() {
    super.onClose();
    repository.closeHomeStream(); //TODO: Conferir se é necessario
  }

  _fetchTodayMeals() async {
    var dailyMeals =
        await repository.fetchDailyMeals(day: todayIndex - 1); //FIXME: Erro aq
    if (dailyMeals.isNotEmpty) {
      mealsOfTheDay.assignAll(
          (dailyMeals).map((meal) => MealCardModel(mealModel: meal)));
    }
    overViewMeals = dailyMeals
        .map(
          (meal) => {
            'image': meal.mainFoodList.first.img,
            'title':
                '${MealModelHelper.getTranslatedMeal(meal.mealType)}:\n${meal.mainFoodList.first.title}',
          },
        )
        .toList();
  }

  _setMeal(int idx) async {
    var meal = mealsOfTheDay[idx].mealModel;
    selectedMainFoodIdx.value = 0;
    mainFoodsAvailable.assignAll(meal.mainFoodList);
    extraFoodsAvailable.assignAll(meal.extraList);
    _extrasAmount.value = meal.extraAmount;
    selectedExtras = [];
    _selectedExtrasList.assignAll([]);
    mealCategory.value = MealModelHelper.getTranslatedMeal(meal.mealType);
  }

  _setDayOfTheWeek() {
    todayIndex = DateTime.now().weekday;
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

  backToTodayPressed() => _showDayOverView(dayIndex.value = 0);

  _backToToday() => _homeBodyState.value = lastHomeBodyState;

  onShowTomorrowOverViewPressed() => _showDayOverView(dayIndex.value = 1);

  _showDayOverView(int day) async {
    if (homeBodyState != HomeBodyState.OtherDayOverview)
      lastHomeBodyState = homeBodyState;
    if (day <= 0) {
      isPreviewBtnDisabled.value = true;
      return _backToToday();
    } else {
      isPreviewBtnDisabled.value = false;
      _homeBodyState.value = HomeBodyState.OtherDayOverview;
    }
    if (day >= 6) {
      isNextBtnDisabled.value = true;
    } else {
      isNextBtnDisabled.value = false;
    }
    //TODO: Acho que preciso esperar os dados chegarem, circular progress indicator
    var dailyMeals =
        await repository.fetchDailyMeals(day: ((todayIndex + day) - 1) % 7);
    overViewMealsOfOtherDay = dailyMeals.map(
      (meal) {
        return {
          'image': meal.mainFoodList.first.img,
          'title':
              '${MealModelHelper.getTranslatedMeal(meal.mealType)}:\n${meal.mainFoodList.first.title}',
        };
      },
    ).toList();
  }

  showMealsCard() {
    pageController.jumpToPage(1);
    _homeBodyState.value = HomeBodyState.Meals;
  }

  void onPreviewDayPressed() => _showDayOverView(--dayIndex.value);
  // isNextBtnDisabled.value = false;

//BUG: O dia de amanha está mostrando o overview igual ao do dia de hoje quando toco na seta
//BUG: Comportamento estranho em algumas refeições especificas quando vai passando os dias do overview
  onNextDayPressed() => _showDayOverView(++dayIndex.value);

//Se eu criar a diferenca de dias, eu sei que -1 é ontem, 0 é hoje, +1 é amanha
// Eu posso informar a diferença de dias

  String getDayTitle() =>
      HomeScreenHelper.getDayTitle(dayIndex.value, todayIndex);
}

abstract class HomeScreenHelper {
  static String getDayTitle(int dayIndex, int todayIndex) {
    if (dayIndex == 1) {
      return 'AMANHÃ';
    } else if (dayIndex == -1) {
      return 'ONTEM';
    } else if (dayIndex == 0) {
      return 'HOJE';
    } else
      return getDayOfTheWeekString(dayOnTheWeekToString(todayIndex + dayIndex));
  }

  static int dayOnTheWeekToString(int dayNum) {
    if (dayNum > 7) {
      dayNum = (dayNum % 7);
    } else if (dayNum < 1) {
      dayNum = (dayNum % 7);
    }
    if (dayNum == 0) dayNum = 7;

    return dayNum;
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
