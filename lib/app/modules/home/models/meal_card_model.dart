import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/meal_model.dart';

class MealCardModel {
  final MealModel mealModel;
  MealCardState mealCardState  = MealCardState.None;
  List<int> extrasSelectedIndex = [];

  MealCardModel({
    @required this.mealModel,
  });

  @override
  String toString() =>
      'MealCardModel(mealModel: $mealModel)';
}

enum MealCardState {
  Skiped,
  None,
  Done,
}
