import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/modules/home/models/meal_model.dart';
import 'package:nutri/app/modules/home/models/menu_model.dart';
import 'package:nutri/app/modules/home/repositories/home_repository.dart';
import 'package:nutri/app/modules/home/helpers/home_helper.dart';
import 'package:nutri/app/modules/home/models/meal_card_model.dart';
import 'package:nutri/app/modules/home/providers/home_provider.dart';
import 'package:nutri/app/routes/app_pages.dart';

//TODO: Receber o dia que foi buildado as refeições semanais
// - Receber qual a semana do ano, por exemplo o ano tem aprox 52 semanas
// - Salva o dia da semana e a semana do ano, se tiver no mesmo dia na semana seuginte, mostra o food swipe
//O dia máximo que o user pode olhar é até 6 dias incluindo o dia do build;(Ou 7, começando de amanha??)
//O user pode olhar os dias anteriores, até no maximo o dia que foi buildado
// Ex, se eu buildei na segunda, só posso olhar até segunda que vem(ou dom da msm semana, sendo a segunda tb um dos dias do build da semana)
// Entao obrigar a pessoa a escolher novamente o foodswipe na segunda que vem

//BUG:? Quando termino de escolher as comidas do foodswipe apos criar uma conta,
// ela ja vem com as comidas salvas antes de criar a conta

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

//TODO: Quando o user termina as refeições do dia ele vai pra a review page
// Na review page voce pode dar um overview no proximo dia, o botao irá alterar para ser, 'ver review de hoje'

enum HomeBodyState {
  Loading,
  Overview,
  Meals,
  Review,
  OtherDayOverview,
}

//Home controller ficará responsável pelo estado e pelo titulo, pelos botoes no titulo e pelos botoes na navbar

class HomeController extends GetxController {
  HomeController({required this.repository});
  final HomeRepository repository;

  final isPreviewBtnDisabled = true.obs;
  //TODO: Mostrar pagina de review de dias anteriores
  final isNextBtnDisabled = false.obs;

  final mealCardsOfTheDay = <MealCardModel>[].obs;

  var lastHomeBodyState = HomeBodyState.OtherDayOverview;

  final mealListLenght = 0.obs;

  List<FoodModel> mainFoodsAvailable = <FoodModel>[];
  RxBool isMainFoodsReady = false.obs;
  final extraFoodsAvailable = <FoodModel>[].obs;

  List<MealModel> overViewList = [];

  final RxBool _showHomeContent = false.obs;
  bool get showHomeContent => _showHomeContent.value!;

  final dayIndex = 0.obs;

  int mealIndex = 0;

  final selectedMainFoodIdx = 0.obs;

  final _selectedExtrasList = <int>[].obs;
  List<int> get selectedExtrasList => _selectedExtrasList;

  List<Map<String, String>> overViewMeals = [];
  List<Map<String, String>> overViewMealsOfOtherDay = [];
  List<Map<String, String>> reviewMeals = [];
  List<MealCardModel> reviewMealCards = [];

  List<FoodModel> selectedExtras = [];

  final _extrasAmount = 3.obs;
  int get extrasAmount => _extrasAmount.value;

  final mealCategory = 'Café da manhã'.obs;

  Rx<HomeBodyState> _homeBodyState = HomeBodyState.Loading.obs;
  HomeBodyState get homeBodyState => _homeBodyState.value!;

  late PageController pageController;

  late Rx<HomeState> homeState = HomeState.Loading.obs;

  @override
  void onInit() {
    super.onInit();
    homeState.bindStream(repository.getHomeState());

    ever(homeState, onHomeStateChanged);
    ever(_homeBodyState, onHomeBodyStateChanged);
    _getOverViewList(0); //TODO: Setar o dia que quero o overview
    _fetchPageIndex();
  }

  onHomeBodyStateChanged(state) {
    switch (state) {
      case HomeBodyState.Overview:
        print('over');
        break;
      case HomeBodyState.Review:
        _fetchReview();

        print('review');
        break;
      case HomeBodyState.Meals:
        _onPageChanged(0);
        _setMeal(0);

        break;
      default:
    }
  }

  _getOverViewList(day) async {
    overViewList = await repository.getMeals(day: day);
  }

  onHomeStateChanged(state) {
    switch (state) {
      case HomeState.Ready:
        _showHomeContent.value = true;
        break;
      case HomeState.Error:
        Get.offAllNamed(Routes.FOOD_SWIPE);
        break;
      default:
        break;
    }
  }

  onPageChanged(int idx) => _onPageChanged(idx);

  String getDayTitle()  =>  repository
      .getDayTitle(day: dayIndex.value); //TODO: Esse pode ser mais complicado

  _fetchPageIndex() async {
    var pgIndex = await repository.getPageIndex();
    pgIndex = 0;

    pageController = PageController(initialPage: pgIndex);
    await _fetchTodayMeals(); //TODO: Trocar a hora em que o home decide se mostra ou nao HomeState.Ready
    if (pgIndex == 0) _homeBodyState.value = HomeBodyState.Overview;
    // if (pgIndex) _homeBodyState.value = HomeBodyState.Overview;
  }

  _onPageChanged(int idx) async {
    _savePageIndex(idx);
  }

  _savePageIndex(int idx) => repository.setPageIndex(idx);

  onDonePressed() => _nextMealCard(true);

  onSkippedPressed() => _nextMealCard(false);

  _nextMealCard(bool confirmed) {
    myMealCard.mealCardState =
        confirmed ? MealCardState.Done : MealCardState.Skiped;
    myMealCard.selectedFood = mainFoodsAvailable[selectedMainFoodIdx.value];
    // _saveMealCard(myMealCard);
    _nextPage();
  }

  _saveMealCard(MealCardModel m) {
    repository.saveMealCard(m.mealModel.mealType.toString(), m.toJson());
  }

  _nextPage() {
    pageController.nextPage(
      duration: Duration(microseconds: 100),
      curve: Curves.ease,
    );
  }

  _fetchReview() async {
    List<String> savedMealList = await repository.getMealsCard();
    var listMealCards =
        savedMealList.map((s) => MealCardModel.fromJson(s)).toList();
    reviewMeals = listMealCards
        .map((m) => {
              'image': m.selectedFood!.img,
              'title': m.selectedFood!.title,
              'color': m.mealCardState.toString(),
            })
        .toList();
  }

  @override
  void onClose() {
    super.onClose();
    repository.closeHomeStream(); //TODO: Conferir se é necessario
  }

  _fetchTodayMeals() async {
    var dailyMeals =
        await repository.fetchDailyMeals(); //FIXME: Pegar o dia da semana
    if (dailyMeals.isNotEmpty) {
      mealCardsOfTheDay.assignAll(
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

  late MenuModel myMeal;
  late MealCardModel myMealCard;

  _setMeal(int idx) async {
    myMeal = mealCardsOfTheDay[idx].mealModel;
    myMealCard = mealCardsOfTheDay[idx];
    selectedMainFoodIdx.value = 0;
    mainFoodsAvailable.assignAll(myMeal.mainFoodList);
    isMainFoodsReady.value = true;
    extraFoodsAvailable.assignAll(myMeal.extraList);
    _extrasAmount.value = myMeal.extraAmount;
    selectedExtras = [];
    _selectedExtrasList.assignAll([]);
    mealCategory.value = MealModelHelper.getTranslatedMeal(myMeal.mealType);
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
    mealCardsOfTheDay[mealIndex].mealCardState = MealCardState.Done;
    mealCardsOfTheDay[mealIndex].selectedFood = mealCardsOfTheDay[mealIndex]
        .mealModel
        .mainFoodList[selectedMainFoodIdx.value];
    mealCardsOfTheDay[mealIndex].selectedExtras = selectedExtras;
    _buildAndSavePrefs(mealCardsOfTheDay[mealIndex]);
  }

  _buildAndSavePrefs(MealCardModel mealCard) {
    List<String> prefStringList = [];
    var extrasStringList = mealCard.selectedExtras.map((extra) => extra.title);
    prefStringList.add(mealCard.mealCardState.toString());
    prefStringList.add(mealCard.selectedFood!.title);
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
    overViewList =
        await repository.getMeals(day: day); //TODO: Definir o dia que quero
  }

  showMealsCard() {
    _homeBodyState.value = HomeBodyState.Meals;
  }

  void onPreviewDayPressed() => _showDayOverView(--dayIndex.value);
  // isNextBtnDisabled.value = false;

  onNextDayPressed() => _showDayOverView(++dayIndex.value);

//Se eu criar a diferenca de dias, eu sei que -1 é ontem, 0 é hoje, +1 é amanha
// Eu posso informar a diferença de dias

}
