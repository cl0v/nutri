import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nutri/app/data/model/food_model.dart';

const jsonPath = 'assets/jsons/food_data.json';

class FoodProvider {
  FoodProvider();

  Future<List> _loadJson() async =>
      jsonDecode(await rootBundle.loadString(jsonPath));

  Future<List<FoodModel>> loadFoods() async {
    var json = await _loadJson();
    return json.map((j) => FoodModel.fromJson(j)).toList();
  }

  Future<List<FoodModel>> sizedFoodList(int amount) async =>
      (await loadFoods()).take(amount).toList();
}
