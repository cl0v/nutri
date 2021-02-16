import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/repositories/food_repository.dart';

class HomeController extends GetxController {
  var _mealList = <MealModel>[].obs;
//TODO: Receber a lista de meal
  List<FoodModel> foodList = fList;

  final FoodRepository foodRepository;

  HomeController({@required this.foodRepository});

  CarouselController c = CarouselController();

  @override
  void onInit() {
    super.onInit();
    fetchFoodList();
  }

  fetchFoodList() async {
    // _mealList.assignAll(await foodRepository.loadFoodList());
  }

  onDonePressed() {
    //TODO: Implement onDonePressed
    c.nextPage();
  }

  onInfoPressed(){
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
