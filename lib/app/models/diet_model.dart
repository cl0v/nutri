import 'package:nutri/app/models/meal_model.dart';

import 'food_model.dart';

class DietModel {
  MealModel meal;
  List<FoodModel> mainFoodList;
  List<FoodModel> extraFoodList;

  DietModel({
    required this.meal,
    required this.mainFoodList,
    required this.extraFoodList,
  });

}
