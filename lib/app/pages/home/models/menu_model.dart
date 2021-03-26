import 'package:nutri/app/models/diet_model.dart';
import 'package:nutri/app/models/food_model.dart';
import 'package:nutri/app/models/meal_model.dart';

class MenuModel {
  MealModel meal;
  List<FoodModel> mainFoodList;
  List<FoodModel> extraFoodList;

  MenuModel({
    required this.meal,
    required this.mainFoodList,
    required this.extraFoodList,
  });

  factory MenuModel.fromDietModel(DietModel diet) {
    return MenuModel(
      meal: diet.meal,
      mainFoodList: diet.mainFoodList,
      extraFoodList: diet.extraFoodList,
    );
  }
}
