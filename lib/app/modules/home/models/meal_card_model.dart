import 'package:flutter/foundation.dart';

import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';

class MealCardModel {
  final MealModel mealModel;
  MealCardState mealCardState = MealCardState.None;
  late FoodModel selectedFood;
  late List<FoodModel> selectedExtras;

  MealCardModel({
    required this.mealModel,
  });
}

enum MealCardState {
  Skiped,
  None,
  Done,
}
