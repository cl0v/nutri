import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/repositories/user_preferences_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';

const foodJson = 'assets/jsons/food_data.json';

class FoodSwipeController extends GetxController {
  final UserPreferencesRepository userPreferencesRepository;

  FoodSwipeController({this.userPreferencesRepository});

  RxList<FoodModel> _foodList = <FoodModel>[].obs;
  List<FoodModel> get foodList => _foodList;

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
    _foodList.assignAll(await loadFoodList());
  }

//TODO: Quando o usuario clica em alguma das opçoes de voto, a imagem deverá sumir e o valor fica salvo

  _loadJson() async {
    return await rootBundle.loadString(foodJson);
  }

  Future<List<FoodModel>> loadFoodList() async {
    var data = await _loadJson();
    List jsonList = jsonDecode(data);
    return jsonList.map((e) => FoodModel.fromJson(e)).toList();
  }

  String getPreparoFormated(List<String> prep) {
    var a = StringBuffer();
    prep.forEach((str) {
      a.write('- $str\n');
    });
    return a.toString();
  }

  void onRatingTapped(FoodModel food, double rating) {
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
