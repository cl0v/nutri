import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';

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

  Future<List<FoodModel>> loadAvailableFoods() async {
    List<FoodModel> foodList = await loadFoodList();
    return foodList.map(
      (food) => FoodModel(
          img: food.img,
          title: food.title,
          prefs: food.prefs,
          desc: food.desc,
        ),
    ).toList();
  }

//TODO: Implementar sistema de decisao para quais refeições a pessoa deverá comer

  Future<List<MealModel>> loadMeals() async {
    var foodList = await loadFoodList();
    return foodList
        .map((food) => MealModel.fromFoodModel(food)) //Temp
        .toList();
  }

  String getPreparoFormated(List<String> prep) {
    var a = StringBuffer();
    prep.forEach((str) {
      a.write('- $str\n');
    });
    return a.toString();
  }
}
