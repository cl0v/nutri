import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/models/meal_model.dart';

abstract class IMealProvider {
  Future<MealModel> fetchMeal(String day, MealType mealType);
}

class MealProvider implements IMealProvider {
  final ILocalStorage storage;

  MealProvider({
    required this.storage,
  });

  Future<MealModel> fetchMeal(day, mealType) async {
    List<MealModel> meals = await _fetchDailyMeals(day);
    return meals.firstWhere((meal) => meal.type == mealType);
  }

  Future<List> _loadJson() async =>
      jsonDecode(await rootBundle.loadString('assets/jsons/meal.json'));

  Future<List<MealModel>> _fetchDailyMeals(String day) async {
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
    //Cria a lista de meals do dia, caso a pessoa aperte para ver mais um dia, vai criar esse tambem e deixar salvo...
    //cria a medida que for solicitado
    //Lembrando que quero apenas os meals e nao o menu(diet)
  }
}
