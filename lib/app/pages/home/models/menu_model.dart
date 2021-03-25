import 'package:nutri/app/models/food_model.dart';
import 'package:nutri/app/pages/home/models/meal_model.dart';

class MenuModel {
  MealModel overview;
  List<FoodModel> mainFoodList;
  List<FoodModel> extraFoodList;
  
  MenuModel({
    required this.overview,
    required this.mainFoodList,
    required this.extraFoodList,
  });
}

