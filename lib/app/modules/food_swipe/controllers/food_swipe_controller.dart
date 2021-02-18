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

  Map<String, int> foodPrefs = Map<String, int>();

  final _isOkey = false.obs;
  bool get isOkey => _isOkey.value;

  @override
  void onInit() {
    //TODO: Tornar o food swipe uma pagina que será acessada varias vezes por fontes
    //TODO: Informar o que está sendo escolhido(Cafe da manha, almoço, etc)
    //TODO: Informar para quando está sendo escolhido(HOJE, SEMANA)

    super.onInit();
    _fetchFoodsAvailable();
    pageController = PageController(viewportFraction: 0.8)
      ..addListener(() {
        _currentPageValue.value = pageController.page;
      });
  }

  onSkipPressed() {
    Get.offAllNamed(Routes.HOME);
  }

  onBuildCardapioPressed() {
    _isOkey.value = true;
    print(isOkey);
  }

  _fetchFoodsAvailable() async {
    _foodList.assignAll(await foodRepository.loadFoodList());
  }

  void onRatingTapped(FoodModel food, double rating) {
    foodPrefs[food.prefs] = rating.round();
    if (pageController.page.round() == foodList.length - 1) {
      _savePrefs();
      Get.offAllNamed(Routes.HOME);
    }
    pageController.nextPage(
        duration: Duration(milliseconds: 10), curve: Curves.ease);
  }

  void _savePrefs() {
    foodPreferencesRepository.setFoodsPrefs(foodPrefs);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
