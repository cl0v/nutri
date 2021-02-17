import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/extras_model.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/repositories/food_repository.dart';

class HomeController extends GetxController {
  RxList<MealModel> _mealList = <MealModel>[].obs;
  List<MealModel> get mealList => _mealList;

// TODO: Receber a lista de extras
// TODO: Adicionar animaçao para quando tocar no acompanhamento

  List<FoodModel> foodList = fList;

  var extras = <ExtraModel>[
    ExtraModel(food: fList[1], amount: 2, unidade: 'unidades'),
    ExtraModel(food: fList[0], amount: 1, unidade: 'chícara'),
    ExtraModel(food: fList[2], amount: 3, unidade: 'porções'),
    ExtraModel(food: fList[0], amount: 1, unidade: 'chícara'),
    ExtraModel(food: fList[2], amount: 3, unidade: 'porções'),
    ExtraModel(food: fList[1], amount: 2, unidade: 'unidades'),
  ];

  final FoodRepository foodRepository;

  HomeController({@required this.foodRepository});

  CarouselController c = CarouselController();

  @override
  void onInit() {
    super.onInit();
    fetchFoodList();
  }

  fetchFoodList() async {
    _mealList.assignAll(await foodRepository.loadMeals());
  }

  onExtraTapped(ExtraModel ex) {
    //  TODO: Implement onExtra Tapped
  }

  onDonePressed() {
    //TODO: Implement onDonePressed
    c.nextPage();
  }

  onInfoPressed() {
    //TODO: Implement on card info pressed
  }
  // @override
  // void onReady() {}

  // @override
  // void onClose() {}

}

List<FoodModel> fList = [
  FoodModel(
    img:
        'https://i.pinimg.com/474x/e2/fe/5c/e2fe5c199feb50e474ce4f2c98c5274b.jpg',
    // texto: 'Café da manhã',

    title: 'Café preto',
  ),
  FoodModel(
    img:
        'https://i.pinimg.com/564x/e0/d1/08/e0d108f2b18bc168edc824bfab8399a2.jpg',
    // texto: 'Almoço',
    title: 'Peito de frango',
  ),
  FoodModel(
    img:
        'https://i.pinimg.com/474x/de/58/f7/de58f749a33fb02aca97492b35e73382.jpg',
    // texto: 'Jantar',
    title: 'Carne com brocolis',
  ),
];
