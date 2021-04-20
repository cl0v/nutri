import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/models/meal_model.dart';

abstract class IMealProvider {
  Future<MealModel> fetchMealByType(MealType type); //TODO: Usar esse
}

//TODO: Pensar se devo implementar esse carinha
//Será responsável por buildar os meals, e a ordem de cada
abstract class IDietMealBuilder {
  Future requestMeal(MealType type);
  Future buildMeals();
}

class MealProvider implements IMealProvider {
  @override
  Future<MealModel> fetchMealByType(MealType type) async {
    var json = await _loadJson();
    var list = json.map((map) => MealModel.fromMap(map)).toList()..shuffle();
    return list.firstWhere((element) => element.type == type);
  }

  Future<List> _loadJson() async =>
      jsonDecode(await rootBundle.loadString('assets/jsons/meal.json'));
}
