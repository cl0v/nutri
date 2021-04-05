import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/models/meal_model.dart';

abstract class IMealProvider {
  Future<MealModel> fetchMeal(int day, MealType mealType);
}

class MealProvider implements IMealProvider {
  Future<List> _loadJson() async =>
      jsonDecode(await rootBundle.loadString('assets/jsons/meal.json'));

  Future<MealModel> fetchMeal(day, mealType) async {
    var json = await _loadJson();

    return json
        .map((map) => MealModel.fromMap(map))
        .where((meal) => meal.day == day)
        .firstWhere((meal) => meal.type == mealType);
  }
}
