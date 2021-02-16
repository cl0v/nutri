import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/food_rating_card_model.dart';
import 'package:nutri/app/data/repositories/food_repository.dart';
import 'package:nutri/app/data/repositories/user_preferences_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';

class FoodSwipeController extends GetxController {
  final UserPreferencesRepository userPreferencesRepository;
  final FoodRepository foodRepository;

  FoodSwipeController(
      {this.userPreferencesRepository, @required this.foodRepository});

  RxList<FoodRatingCardModel> _foodList = <FoodRatingCardModel>[].obs;
  List<FoodRatingCardModel> get foodList => _foodList;

  PageController pageController;
  final _currentPageValue = 0.0.obs;
  double get currentPageValue => _currentPageValue.value;

  Map<String, int> foodPrefs = Map<String, int>();

  @override
  void onInit() {
    super.onInit();
    _fetchFoodsAvailable();
    pageController = PageController(viewportFraction: 0.8)
      ..addListener(() {
        _currentPageValue.value = pageController.page;
      });
  }

  onSkipPressed() {
    savePrefs();
    Get.offNamed(Routes.HOME);
    //Possivelmente trocar para botao salvar e o usuário salvara as preferencias
    //TODO: Implement onSkipPressed
  }

  _fetchFoodsAvailable() async {
    _foodList.assignAll(await foodRepository.loadAvailableFoods());
  }

//TODO: Quando o usuario clica em alguma das opçoes de voto, a imagem deverá sumir e o valor fica salvo

 

  void onRatingTapped(food, rating) {
    foodPrefs[food.prefs] = rating.round();
  }

  void savePrefs() {
    userPreferencesRepository.setFoodsPrefs(foodPrefs);
    //TODO: Implement savePrefs
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
