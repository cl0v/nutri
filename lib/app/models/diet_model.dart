import 'dart:convert';

import 'package:nutri/app/models/meal_model.dart';

import 'food_model.dart';

class DietModel extends MealModel {
  List<FoodModel>? mainFoodList;
  List<FoodModel>? extraFoodList;

  DietModel({
    required MealModel meal,
    this.mainFoodList,
    this.extraFoodList,
  }) : super(
          img: meal.img,
          title: meal.title,
          type: meal.type,
        );

  Map<String, dynamic> toMap() {
    return {
      'meal': super.toMap(),
      'mainFoodList': mainFoodList?.map((x) => x.toMap()).toList() ?? [],
      'extraFoodList': extraFoodList?.map((x) => x.toMap()).toList() ?? [],
    };
  }

  factory DietModel.fromMap(Map<String, dynamic> map) {
    return DietModel(
      meal: MealModel.fromMap(map['meal']),
      mainFoodList: List<FoodModel>.from(
          map['mainFoodList']?.map((x) => FoodModel.fromMap(x))),
      extraFoodList: List<FoodModel>.from(
          map['extraFoodList']?.map((x) => FoodModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DietModel.fromJson(String source) =>
      DietModel.fromMap(json.decode(source));
}
