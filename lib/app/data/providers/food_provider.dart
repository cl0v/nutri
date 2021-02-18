import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nutri/app/data/model/food_model.dart';

const jsonPath = 'assets/jsons/food_data.json';

class FoodProvider {
  FoodProvider();

  _loadJson() async {
    return await rootBundle.loadString(jsonPath);
  }

  Future<List<FoodModel>> loadFoodList() async {
    var data = await _loadJson();
    List jsonList = jsonDecode(data);
    return jsonList.map((e) => FoodModel.fromJson(e)).toList();
  }

}
