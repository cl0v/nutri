import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/food_swipe_model.dart';
import 'package:nutri/app/data/repositories/food_preferences_repository.dart';
import 'package:nutri/app/data/repositories/food_swipe_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';

//TODO: No food swipe card, quando a pessoa quiser trocar algum alimento
//TODO: Mostrar apenas os alimentos selecionados para aquela semana(nao permitir adicionar elementos que nao estavam no planejado pra semana, apenas trocar alimentos equivalentes, de dia)

class FoodSwipeController extends GetxController {
  final FoodPreferencesRepository foodPreferencesRepository;
  final FoodSwipeRepository foodSwipeRepository;

  FoodSwipeController({
    this.foodPreferencesRepository,
    this.foodSwipeRepository,
  });

  List<FoodSwipeModel> _foodSwipeList = <FoodSwipeModel>[];
  Rx<FoodSwipeModel> _currentFoodSwipeModel = FoodSwipeModel().obs;
  FoodSwipeModel get currentFoodSwipeModel => _currentFoodSwipeModel.value;

  List<String> _foodPrefs = <String>[];
  var _checkedIndexes = <int>[].obs;

  int currentIndex = 0;

  final _amountSelected = 0.obs;
  int get amountSelected => _amountSelected.value;

  PageController pageController = PageController(viewportFraction: 0.8);

  final _isReady = false.obs;
  bool get isOkey => _isReady.value;

  @override
  void onInit() {
    //TODO: Tornar o food swipe uma pagina que será acessada varias vezes por fontes
    //TODO: Informar para quando está sendo escolhido(HOJE, SEMANA)
    //TODO: Checkar se está vindo de algum lugar com o arguments, se estiver nulo ou vazio, mostrar a primeira pagina (!)
    super.onInit();
    _fetchFoodSwipeList();
  }

  onBuildCardapioPressed() => _isReady.value = true;

  onConfirmPressed() {
    ++currentIndex;
    if (currentIndex == _foodSwipeList.length) {
      _savePrefs();
      Get.offAllNamed(Routes.HOME);
    } else {
      _setShowingFoodSwipe(_foodSwipeList[currentIndex]);
      pageController.jumpToPage(0);
      _amountSelected.value = 0;
      _checkedIndexes.clear();
    }
  }

  onSkipPressed() {
    _savePrefs(); //TODO: Lembrar que estou possibilitando o usuario pular o foodswipe

    Get.offAllNamed(Routes.HOME);
  }

  void onCheckTapped(FoodModel food, int index) {
    if (isChecked(index)) {
      _amountSelected.value--;
      _checkedIndexes.remove(index);
      _foodPrefs.remove(food.title);
    } else if (amountSelected < currentFoodSwipeModel.amount) {
      _amountSelected.value++;
      _checkedIndexes.add(index);
      _foodPrefs.add(food.title);
    }
  }

  bool isChecked(int index) => _checkedIndexes.contains(index);

  _savePrefs() => foodPreferencesRepository.setFoodsPrefs(_foodPrefs);

  _setShowingFoodSwipe(FoodSwipeModel fSwipeModel) =>
      _currentFoodSwipeModel.value = fSwipeModel;

  _fetchFoodSwipeList() async {
    _foodSwipeList = await foodSwipeRepository.loadFoodSwipeList();
    _setShowingFoodSwipe(_foodSwipeList.first);
  }
}
