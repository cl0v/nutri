import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/interfaces/providers/meal_interface.dart';
import 'package:nutri/app/models/meal_model.dart';

class RepositoryMealProvider implements IMealRepository {
  @override
  Future<MealModel> fetchMealByType(MealType type) async {
    var json = await _loadJson();
    var list = json.map((map) => MealModel.fromMap(map)).toList()..shuffle();
    return list.firstWhere((element) => element.type == type);
  }

  Future<List> _loadJson() async =>
      jsonDecode(await rootBundle.loadString('assets/jsons/meal.json'));
}
