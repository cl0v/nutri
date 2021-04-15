import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/models/food_model.dart';

abstract class IFoodProvider {
  Future<List<FoodModel>> loadFoodList(FoodCategory category);
}

class FoodProvider implements IFoodProvider {
  Future<List> _loadJson() async =>
      jsonDecode(await rootBundle.loadString('assets/jsons/food_data.json'));

  @override
  Future<List<FoodModel>> loadFoodList(FoodCategory category) async =>
      (await _loadJson())
          .where((map) =>
              map['category'] == FoodModel.getIndexFromCategory(category))
          .map((map) => FoodModel.fromMap(map))
          .toList()
            ..shuffle();
}
