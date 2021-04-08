import 'package:nutri/app/models/diet_model.dart';
import 'package:nutri/app/models/food_model.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/home_meal_model.dart';

class HomeMealMenuModel extends HomeMealModel {
  final List<FoodModel> mainFoodList;
  final List<FoodModel> extraFoodList;

  HomeMealMenuModel({
    required MealModel meal,
    required this.mainFoodList,
    required this.extraFoodList,
  }) : super(
          type: meal.type,
          img: meal.img,
          title: meal.title
        );

  factory HomeMealMenuModel.fromDietModel(DietModel diet) {
    return HomeMealMenuModel(
      meal: diet.meal,
      mainFoodList: diet.mainFoodList,
      extraFoodList: diet.extraFoodList,
    );
  }
}
