import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/modules/home/enums/home_body_state_enum.dart';
import 'package:nutri/app/modules/home/models/home_review_model.dart';
import 'package:nutri/app/modules/home/models/meal_model.dart';
import 'package:nutri/app/modules/home/models/menu_model.dart';
import 'package:nutri/app/modules/home/repositories/home_repository.dart';
import 'package:nutri/app/modules/home/models/meal_card_model.dart';

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

//TODO: Mostrar pagina de review de dias anteriores

//Home controller ficará responsável pelo estado e pelo titulo, pelos botoes no titulo e pelos botoes na navbar

class HomeController extends GetxController {
  HomeController({required this.repository});
  final HomeRepository repository;

  /// Define se o botão de dia anterior do titulo estará ou não desabilitado
  final isPreviewBtnDisabled = true.obs;

  /// Define se o botão de dia seguinte do titulo estará ou não desabilitado
  final isNextBtnDisabled = false.obs;

  final mealCardsOfTheDay = <MealCardModel>[].obs;

  List<MealModel> overViewList = [];
  RxBool isOverViewReady = false.obs;

  RxBool isReviewReady = true.obs; //TODO: Ainda nem to usando isso

  final dayIndex = 1.obs;

  final selectedMainFoodIdx = 0.obs;

  List<HomeReviewModel> reviewMeals = [];

  Rx<HomeBodyState> _homeBodyState = HomeBodyState.Loading.obs;
  HomeBodyState get homeBodyState => _homeBodyState.value!;

  @override
  void onInit() {
    super.onInit();
    // ever(_homeBodyState, _onHomeBodyStateChanged);
    // Definir um estado no home provider, que dirá em qual página deverá estar
    // Com base em qual página estiver, os respectivos dados serão recebidos

    _getPEOverview();
    _getPEMenu();
    pageController = PageController();
    // _getOverViewList(1);
    // _fetchMealIndex();
  }

  _getPEOverview() async {
    overViewList = await repository.getOverViewListFromPEDietSugestion();
    isOverViewReady.value = true;
  }

  RxBool isMenuReady = true.obs; // TODO: Isso precisa ser true para ser testado
  List<MenuModel> menuList = [];
  _getPEMenu() async {
    menuList = await repository.getMenuListFromPEDietSugestion();
    isMenuReady.value = true;
    _homeBodyState.value = HomeBodyState.Overview;
    isMainFoodsReady.value = true;
  }

  _onHomeBodyStateChanged(state) {
    switch (state) {
      case HomeBodyState.Overview:
        break;
      case HomeBodyState.Review:
        print('review');
        _fetchReview();
        break;
      case HomeBodyState.Menu:
        // _onMenuPageChanged(0);
        // _setMeal(0);
        break;
      default:
    }
  }

  _getOverViewList(day) async {
    overViewList = await repository.getMeals(day: day);
    isOverViewReady.value = true;
  }

  onPageChanged(int idx) => _onMenuPageChanged(idx);

  String getDayTitle() => repository.getDayTitle(day: dayIndex.value);

  /// Recebe o ultimo estado salvo da home page com base no enum HomeBodyState
  //TODO: Implement fetchHomeState
  _fetchHomeState() {
    HomeBodyState state = HomeBodyState.Loading;
    switch (state) {
      case HomeBodyState.Overview:
        print(state);
        break;
      case HomeBodyState.Menu:
        print(state);
        //TODO: Aqui que fica o _fetchMealIndex
        break;
      case HomeBodyState.Review:
        print(state);
        break;
      default:
    }
  }

  /// Recebe o index da ultima refeição salva
  //TODO: Implement _fetchMealIndex
  _fetchMealIndex() async {
    //TODO: Receber o home state, caso seja meal, receber o index do meal
    var pgIdx = await repository.getPageIndex();
    pgIdx = 0;
    //FIXME: Esse pgidx não deve informar a pagina geral e sim o estado da página, caso o estado seja meal, deve informar o index
    pageController = PageController(initialPage: pgIdx);
    await _fetchTodayMeals(); //TODO: Trocar a hora em que o home decide se mostra ou nao HomeState.Ready
    if (pgIdx == 0) _homeBodyState.value = HomeBodyState.Overview;
  }

  /// Chamado toda vez que o usuário confirma ou pula alguma refeição
  _onMenuPageChanged(int idx) async {
    if (idx >= 4) return _homeBodyState.value = HomeBodyState.Review;
    _savePageIndex(idx);
    // _setMeal(idx);
  }

  /// Salva a ultima refeição mostrada para o usuário
  _savePageIndex(int idx) => repository.setPageIndex(idx);

  // Menu //

  final _selectedExtrasList = <int>[].obs;
  List<int> get selectedExtrasList => _selectedExtrasList;
  late PageController pageController;

  List<FoodModel> selectedExtras = [];

  final _extrasAmount = 3.obs;
  int get extrasAmount => _extrasAmount.value;

  final mealCategory = 'Café da manhã'.obs;

  onDonePressed() => _nextMealCard(true);

  onSkippedPressed() => _nextMealCard(false);

  List<FoodModel> mainFoodsAvailable = [];
  RxBool isMainFoodsReady = false.obs;
  final extraFoodsAvailable = <FoodModel>[].obs;

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
    //FIXME: Refazer esse cara
    List<String> savedMealList = await repository.getMealsCard();
    var listMealCards =
        savedMealList.map((s) => MealCardModel.fromJson(s)).toList();
    reviewMeals = listMealCards
        .map((m) => HomeReviewModel(
              image: m.selectedFood!.img,
              title: m.selectedFood!.title,
              done: m.mealCardState == MealCardState.Done,
            ))
        .toList();
    isReviewReady.value = true;
  }

  @override
  void onClose() {
    super.onClose();
    repository.closeHomeStream(); //TODO: Conferir se é necessario
  }

  _fetchTodayMeals() async {
    //TODO: Fetch next meal
    var dailyMeals = await repository.getMenuListFromPEDietSugestion();
    // await repository.fetchDailyMeals(); //FIXME: Pegar o dia da semana
    if (dailyMeals.isNotEmpty) {
      mealCardsOfTheDay.assignAll(
          (dailyMeals).map((meal) => MealCardModel(mealModel: meal)));
    }
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

  onMainFoodTapped(int idx) {
    print(idx);
    return selectedMainFoodIdx.value = idx;
  }

  bool isMainFoodSelected(int idx) => selectedMainFoodIdx.value == idx;

  onExtraTapped(int idx) {
    print(_selectedExtrasList); // Refazer esse cara
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

  _showDayOverView(int day) async {
    if (day <= 0) {
      isPreviewBtnDisabled.value = true;
    } else {
      isPreviewBtnDisabled.value = false;
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
    _homeBodyState.value = HomeBodyState.Menu;
  }

  void onPreviewDayPressed() => _showDayOverView(--dayIndex.value);
  // isNextBtnDisabled.value = false;

  onNextDayPressed() => _showDayOverView(++dayIndex.value);
}



  // _saveMealOfTheDay() {
  //   mealCardsOfTheDay[mealIndex].mealCardState = MealCardState.Done;
  //   mealCardsOfTheDay[mealIndex].selectedFood = mealCardsOfTheDay[mealIndex]
  //       .mealModel
  //       .mainFoodList[selectedMainFoodIdx.value];
  //   mealCardsOfTheDay[mealIndex].selectedExtras = selectedExtras;
  //   _buildAndSavePrefs(mealCardsOfTheDay[mealIndex]);
  // }

  // _buildAndSavePrefs(MealCardModel mealCard) {
  //   List<String> prefStringList = [];
  //   var extrasStringList = mealCard.selectedExtras.map((extra) => extra.title);
  //   prefStringList.add(mealCard.mealCardState.toString());
  //   prefStringList.add(mealCard.selectedFood!.title);
  //   prefStringList.addAll(extrasStringList);
  //   // repository.saveMealPrefs(
  //   //     mealCard.mealModel.mealType.toString(), prefStringList);
  //   //TODO: Analizar esse carinha
  // }