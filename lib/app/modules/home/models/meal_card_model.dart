import 'package:flutter/foundation.dart';

import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';

class MealCardModel {
  final MealModel mealModel;
  MealCardState mealCardState = MealCardState.None;
  FoodModel selectedFood;
  List<FoodModel> selectedExtras;

  MealCardModel({
    @required this.mealModel,
  });

  @override
  String toString() {
    return 'MealCardModel( mealCardState: $mealCardState, selectedFood: $selectedFood, selectedExtras: $selectedExtras)';
  }
}

enum MealCardState {
  Skiped,
  None,
  Done,
}
