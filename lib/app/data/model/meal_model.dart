import 'package:nutri/app/data/model/food_model.dart';

class MealModel {
  String meal; //Pode ser enum
  FoodModel food;

  MealModel({
    this.meal,
    this.food,
  });

  static List<String> mealList = [
    "breakfast",
    "brunch",
    "elevenses",
    "lunch",
    "tea",
    "supper",
    "dinner",
  ];
}
