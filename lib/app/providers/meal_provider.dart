import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/models/meal_model.dart';

abstract class IMealProvider {
  Future<List<MealModel>> fetchMealList(String day);
  Future<MealModel> fetchMeal(String day, MealType mealType);
  //TODO: Receber esse cara por database 
}

class MealProvider implements IMealProvider {
  final ILocalStorage storage;

  MealProvider({
    required this.storage,
  });

  Future<MealModel> fetchMeal(day, mealType) async {
    List<MealModel> meals = await _requestDailyMeals(day);
    return meals.firstWhere((meal) => meal.type == mealType);
  }

  Future<List<MealModel>> fetchMealList(String day)  {
    return _requestDailyMeals(day);
  }

  Future<List> _loadJson() async =>
      jsonDecode(await rootBundle.loadString('assets/jsons/meal.json'));

  Future<List<MealModel>> _requestDailyMeals(String day) async {
    List? list = await storage.get('$day/meals');
    if (list == null) {
      await _buildDailyMeals(day);
      list = await storage.get('$day/meals');
    }
    List<MealModel> meals = list!.map((j) => MealModel.fromJson(j)).toList();
    return meals;
  }

  Future<void> _buildDailyMeals(String day) async {
    var json = await _loadJson();
    List<MealModel> meals = json.map((map) => MealModel.fromMap(map)).toList();
    meals.shuffle();
    List<String> list = [
      meals.firstWhere((meal) => meal.type == MealType.breakfast).toJson(),
      meals.firstWhere((meal) => meal.type == MealType.lunch).toJson(),
      meals.firstWhere((meal) => meal.type == MealType.snack).toJson(),
      meals.firstWhere((meal) => meal.type == MealType.dinner).toJson(),
    ];
    await storage.put('$day/meals', list);
  }
}
