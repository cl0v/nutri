import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/pages/home/enums/home_body_state_enum.dart';
import 'package:nutri/app/pages/home/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';
import 'package:nutri/app/pages/home/repositories/home_repository.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';

//TODO: Receber o dia que foi buildado as refeições semanais
// - Receber qual a semana do ano, por exemplo o ano tem aprox 52 semanas
// - Salva o dia da semana e a semana do ano, se tiver no mesmo dia na semana seuginte, mostra o food swipe
//O dia máximo que o user pode olhar é até 6 dias incluindo o dia do build;(Ou 7, começando de amanha??)
//O user pode olhar os dias anteriores, até no maximo o dia que foi buildado
// Ex, se eu buildei na segunda, só posso olhar até segunda que vem(ou dom da msm semana, sendo a segunda tb um dos dias do build da semana)
// Entao obrigar a pessoa a escolher novamente o foodswipe na segunda que vem

//BUG:? Quando termino de escolher as comidas do foodswipe apos criar uma conta,
// ela ja vem com as comidas salvas antes de criar a conta
//SOLUTION: Salvar como mapa com o nome do user user/foodprefs



class HomeController extends GetxController {
  HomeController({required this.repository});
  final HomeRepository repository;

  /// Define se o botão de dia anterior do titulo estará ou não desabilitado
  final isPreviewBtnDisabled = true.obs;

  /// Define se o botão de dia seguinte do titulo estará ou não desabilitado
  final isNextBtnDisabled = false.obs;

  late PageController pageController;

  final selectedMainFoodIdx = 0.obs;

  Rx<HomeBodyState> _homeBodyState = HomeBodyState.Loading.obs;
  HomeBodyState get homeBodyState => _homeBodyState.value!;

  @override
  void onInit() {
    super.onInit();
    ever(_homeBodyState, onHomeBodyStateChanged);
    _fetchInitialHomeBodyState(); // > Retorna o HomeBodyState
  }

  onHomeBodyStateChanged(state) {
    switch (state) {
      case HomeBodyState.Overview:
        _setOverview();
        break;
      case HomeBodyState.Menu:
        _setMenu();
        break;
      case HomeBodyState.Review:
        _setReview();
        break;
      case HomeBodyState.Loading:
        break;
      default:
    }
  }

  _fetchInitialHomeBodyState() {
    //TODO: Implement _fetchInitialHomeBodyState
    _homeBodyState.value = HomeBodyState.Overview;
  }

  RxBool isOverViewReady = false.obs;
  List<OverviewModel> overViewList = [];
  _setOverview() async {
    overViewList = await repository.getOverViewListFromPEDietSugestion();
    isOverViewReady.value = true;
  }

  RxBool isMenuReady = true.obs;
  List<MenuModel> menuList = [];
  _setMenu() async {
    pageController = PageController();
    menuList = await repository.getMenuListFromPEDietSugestion();
    isMenuReady.value = true;
  }

  RxBool isReviewReady = false.obs; //TODO: Ainda nem to usando isso
  List<ReviewModel> reviewList = []; //TODO: Usar no review page
  List<bool> doneList = [];
  _setReview() {
    overViewList.forEach((element) {
      var idx = overViewList.indexOf(element);
      reviewList
          .add(ReviewModel(overviewModel: element, isDone: doneList[idx]));
    });
    isReviewReady.value = true;
  }


  final dayIndex = 1.obs;
  String getDayTitle() => repository.getDayTitle(day: dayIndex.value);
  //FIXME: Titulo não está funcionando direito
  onPreviewDayPressed() => _showDayOverView(--dayIndex.value);

  onNextDayPressed() => _showDayOverView(++dayIndex.value);

  onMenuPageChanged(int idx) => _onMenuPageChanged(idx);
  
  /// Chamado toda vez que o usuário confirma ou pula alguma refeição
  _onMenuPageChanged(int idx) async {
    if (idx >= 4) {
      _homeBodyState.value = HomeBodyState.Review;
    }
    _savePageIndex(idx);
  }

  onDonePressed() => _nextMealCard(true);

  onSkippedPressed() => _nextMealCard(false);

  /// Salva a ultima refeição mostrada para o usuário
  _savePageIndex(int idx) => repository.setPageIndex(idx);

  // Menu //

//TODO: Remover a selecao dos extras nesse formato
  final _selectedExtrasList = <int>[].obs;
  List<int> get selectedExtrasList => _selectedExtrasList;
  final extraFoodsAvailable = <FoodModel>[].obs;
  List<FoodModel> selectedExtras = [];
  final _extrasAmount = 3.obs;
  int get extrasAmount => _extrasAmount.value;




  _nextMealCard(bool confirmed) {
    //TODO: Implement  _nextMealCard
    // myMealCard.mealCardState =
    //     confirmed ? MealCardState.Done : MealCardState.Skiped;
    // myMealCard.selectedFood = mainFoodsAvailable[selectedMainFoodIdx.value];
    // _saveMealCard(myMealCard);
    doneList.add(confirmed); //TODO: Por enquanto está apenas chamando no final
    _nextPage();
  }

//TODO: Passar pra ViewModel
  _nextPage() {
    pageController.nextPage(
      duration: Duration(microseconds: 100),
      curve: Curves.ease,
    );
  } 


//TODO: Remover 
  getSelectedIndex(int idx) => _selectedExtrasList.contains(idx);

  onMainFoodTapped(int idx) =>
     selectedMainFoodIdx.value = idx;
  




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

}
