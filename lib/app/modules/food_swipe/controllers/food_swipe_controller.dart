import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/repositories/food_preferences_repository.dart';
import 'package:nutri/app/data/repositories/food_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';

class FoodSwipeController extends GetxController {
  final FoodPreferencesRepository foodPreferencesRepository;
  final FoodRepository foodRepository;

  FoodSwipeController({
    this.foodPreferencesRepository,
    @required this.foodRepository,
  });

  RxList<FoodModel> _foodList = <FoodModel>[].obs;
  List<FoodModel> get foodList => _foodList;

  PageController pageController;
  final _currentPageValue = 0.0.obs;
  double get currentPageValue => _currentPageValue.value;

  final _isOkey = false.obs;
  bool get isOkey => _isOkey.value;

  @override
  void onInit() {
    //TODO: Tornar o food swipe uma pagina que será acessada varias vezes por fontes
    //TODO: Informar o que está sendo escolhido(Cafe da manha, almoço, etc)
    //TODO: Informar para quando está sendo escolhido(HOJE, SEMANA)
    //TODO: BUG: Caso eu vire o card e arraste para duas cartas na frente, o estado do primeiro se perde e volta a parte frontal da carta
    //TODO: Checkar se está vindo de algum lugar com o arguments, se estiver nulo ou vazio, mostrar a primeira pagina
    super.onInit();
    _fetchFoodsAvailable();
    pageController = PageController(viewportFraction: 0.8)
      ..addListener(
        () {
          _currentPageValue.value = pageController.page;
        },
      );
  }

  onSkipPressed() {
    Get.offAllNamed(Routes.HOME);
  }

  List<String> _foodPrefs = <String>[];
  var _checkedIndexes = <int>[].obs;

  void onCheckTapped(FoodModel food, int index) {
    if (isChecked(index)) {
      _checkedIndexes.remove(index);
      _foodPrefs.remove(food.prefs);
    } else {
      _checkedIndexes.add(index);
      _foodPrefs.add(food.prefs);
    }
  }
  
  onConfirmPressed() {
    //TODO: Implement onConfirmPressed
    _savePrefs();
    Get.offAllNamed(Routes.HOME);
  }

  void _savePrefs() {
    foodPreferencesRepository.setFoodsPrefs(_foodPrefs);
  }

  bool isChecked(int index) {
    return _checkedIndexes.contains(index);
  }

  onBuildCardapioPressed() {
    _isOkey.value = true;
  }


  _fetchFoodsAvailable() async {
    _foodList.assignAll(await foodRepository.loadFoods());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
