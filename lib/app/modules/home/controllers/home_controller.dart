import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/modules/home/enums/home_body_state_enum.dart';
import 'package:nutri/app/modules/home/models/meal_model.dart';
import 'package:nutri/app/modules/home/models/menu_model.dart';
import 'package:nutri/app/modules/home/repositories/home_repository.dart';
import 'package:nutri/app/modules/home/models/review_model.dart';

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

  List<ReviewModel> mealCardsOfTheDay = [];

  List<OverviewModel> overViewList = [];
  RxBool isOverViewReady = false.obs;

  RxBool isReviewReady = false.obs; //TODO: Ainda nem to usando isso

  final dayIndex = 1.obs;

  final selectedMainFoodIdx = 0.obs;

  Rx<HomeBodyState> _homeBodyState = HomeBodyState.Loading.obs;
  HomeBodyState get homeBodyState => _homeBodyState.value!;

  @override
  void onInit() {
    super.onInit();
    _getPEOverview();
    //TODO: Receber o estado da página com base na shared prefs
  }

  _getPEOverview() async {
    overViewList = await repository.getOverViewListFromPEDietSugestion();
    _homeBodyState.value = HomeBodyState.Overview;
    isOverViewReady.value = true;
  }

  RxBool isMenuReady = true.obs; // TODO: Isso precisa ser true para ser testado
  List<MenuModel> menuList = [];
  _getPEMenu() async {
    pageController = PageController();
    menuList = await repository.getMenuListFromPEDietSugestion();
    isMenuReady.value = true;
    isMainFoodsReady.value = true;
    _homeBodyState.value = HomeBodyState.Menu;
    //TALVEZ REMOVER
  }

  List<ReviewModel> reviewList = []; //TODO: Usar no review page
  List<bool> doneList = [];
  _getPEReview() {
    overViewList.forEach((element) {
      var idx = overViewList.indexOf(element);
      reviewList
          .add(ReviewModel(overviewModel: element, isDone: doneList[idx]));
    });
    isReviewReady.value = true;
    return _homeBodyState.value = HomeBodyState.Review;
  }

  onPageChanged(int idx) => _onMenuPageChanged(idx);

  String getDayTitle() => repository.getDayTitle(day: dayIndex.value);
  //TODO: Fazer o titulo funcionar

  /// Chamado toda vez que o usuário confirma ou pula alguma refeição
  _onMenuPageChanged(int idx) async {
    if (idx >= 4) {
      _getPEReview();
    }
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
    //TODO: Implement  _nextMealCard
    // myMealCard.mealCardState =
    //     confirmed ? MealCardState.Done : MealCardState.Skiped;
    // myMealCard.selectedFood = mainFoodsAvailable[selectedMainFoodIdx.value];
    // _saveMealCard(myMealCard);
    doneList.add(confirmed); //TODO: Por enquanto está apenas chamando no final
    _nextPage();
  }


  _nextPage() {
    pageController.nextPage(
      duration: Duration(microseconds: 100),
      curve: Curves.ease,
    );
  }
  //TODO: Pra salvar depois do ondone eu pego o pageController.pageIdx e seto no MealCardModel

  @override
  void onClose() {
    super.onClose();
    repository.closeHomeStream(); //TODO: Conferir se é necessario
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
    _getPEMenu();
  }

  onPreviewDayPressed() => _showDayOverView(--dayIndex.value);

  onNextDayPressed() => _showDayOverView(++dayIndex.value);
}

