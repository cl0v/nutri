import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/food_rating_card_model.dart';

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

  Future<List<FoodRatingCardModel>> loadAvailableFoods() async {
    List<FoodModel> foodList = await loadFoodList();
    var foodRatinList = foodList
        .map(
          (food) => FoodRatingCardModel(
            cooking: getPreparoFormated(food.cooking),
            img: food.img,
            title: food.title,
            prefs: food.prefs,
          ),
        )
        .toList();
    return foodRatinList;
  }

  String getPreparoFormated(List<String> prep) {
    var a = StringBuffer();
    prep.forEach((str) {
      a.write('- $str\n');
    });
    return a.toString();
  }
}
