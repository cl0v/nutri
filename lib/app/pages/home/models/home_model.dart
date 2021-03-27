import 'dart:convert';

import 'package:nutri/app/models/diet_model.dart';
import 'package:nutri/app/models/food_model.dart';
import 'package:nutri/app/models/meal_model.dart';

class HomeModel implements DietModel {

  @override
  MealModel meal;
  @override
  List<FoodModel> mainFoodList;
  @override
  List<FoodModel> extraFoodList;

  HomeModel({
    required this.extraFoodList,
    required this.mainFoodList,
    required this.meal,
  });


  Map<String, dynamic> toMap() {
    return {
      'meal': meal.toMap(),
      'mainFoodList': mainFoodList.map((x) => x.toMap()).toList(),
      'extraFoodList': extraFoodList.map((x) => x.toMap()).toList(),
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      meal: MealModel.fromMap(map['meal']),
      mainFoodList: List<FoodModel>.from(map['mainFoodList']?.map((x) => FoodModel.fromMap(x))),
      extraFoodList: List<FoodModel>.from(map['extraFoodList']?.map((x) => FoodModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) => HomeModel.fromMap(json.decode(source));
}
