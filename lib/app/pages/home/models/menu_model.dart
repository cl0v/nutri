import 'package:nutri/app/models/diet_model.dart';
import 'package:nutri/app/models/food_model.dart';
import 'package:nutri/app/models/meal_model.dart';

import 'home_model.dart';

class MenuModel extends HomeModel {
  MenuModel({
    required MealModel meal,
    required List<FoodModel> mainFoodList,
    required List<FoodModel> extraFoodList,
  }) : super(
          meal: meal,
          mainFoodList: mainFoodList,
          extraFoodList: extraFoodList,
        );

  factory MenuModel.fromDietModel(DietModel diet) { //TODO: Ver como remover isso
    return MenuModel(
      meal: diet.meal,
      mainFoodList: diet.mainFoodList,
      extraFoodList: diet.extraFoodList,
    );
  }

}
