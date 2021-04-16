import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/models/meal_model.dart';

abstract class IMealProvider {
  Future<MealModel> fetchMeal(String day, MealType mealType);
}

//TODO: Pensar se devo implementar esse carinha
abstract class IDietMealBuilder {
  //Será responsável por buildar os meals, e a ordem de cada
  Future requestMeal(MealType type);
  Future buildMeals();
}

class MealProvider implements IMealProvider {
  final ILocalStorage storage;

  MealProvider({
    required this.storage,
  });

  //Meal nao tem a responsabilidade de saber a ordem dos pratosx

  Future<MealModel> fetchMeal(day, type) async {
    var json = await storage.get('$day/${type.toString()}');
    if (json != null) return MealModel.fromJson(json);
    await _buildMeal(day, type);
    json = await storage.get('$day/${type.toString()}');
    return MealModel.fromJson(json);
  }

  _buildMeal(String day, MealType type) async {
    var json = await _loadJson();
    var list = json.map((map) => MealModel.fromMap(map)).toList()..shuffle();
    var meal = list.firstWhere((element) => element.type == type);
    await storage.put('$day/${type.toString()}', meal.toJson());
  }

  Future<List> _loadJson() async =>
      jsonDecode(await rootBundle.loadString('assets/jsons/meal.json'));

}
