import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_rating_card_model.dart';
import 'package:nutri/app/data/repositories/food_repository.dart';
import 'package:nutri/app/data/repositories/user_preferences_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';

class FoodSwipeController extends GetxController {
  final UserPreferencesRepository userPreferencesRepository;
  final FoodRepository foodRepository;

  FoodSwipeController({
    this.userPreferencesRepository,
    @required this.foodRepository,
  });

  RxList<FoodRatingCardModel> _foodList = <FoodRatingCardModel>[].obs;
  List<FoodRatingCardModel> get foodList => _foodList;

  PageController pageController;
  final _currentPageValue = 0.0.obs;
  double get currentPageValue => _currentPageValue.value;

  Map<String, int> foodPrefs = Map<String, int>();

  @override
  void onInit() {
    //TODO: Receber os argumentos Get.argument(origem e objetivo (Trocar comida, trocar cardapio, etc))
    super.onInit();
    _fetchFoodsAvailable();
    pageController = PageController(viewportFraction: 0.8)
      ..addListener(() {
        _currentPageValue.value = pageController.page;
      });
  }

  onSkipPressed() {
    Get.offNamed(Routes.HOME);
    //TODO: Implement onSkipPressed
  }



  _fetchFoodsAvailable() async {
    _foodList.assignAll(await foodRepository.loadAvailableFoods());
  }

  //TODO: Fazer com que a food swipe informe para quando sera as refeicoes(Semana, Cafe da manha HOJE, etc)

  void onRatingTapped(FoodRatingCardModel food, double rating) {
    foodPrefs[food.prefs] = rating.round();
    if (pageController.page.round() == foodList.length - 1) {
      _savePrefs();
      Get.toNamed(Routes.HOME);
    }
    pageController.nextPage(
        duration: Duration(milliseconds: 100), curve: Curves.ease);
    //TODO: Next image
  }

  void _savePrefs() {
    userPreferencesRepository.setFoodsPrefs(foodPrefs);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
