import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:nutri/app/data/model/food_model.dart';

class MealModel {
  //enum
  MealType mealType;
  FoodModel mainFood;
  List<FoodModel> extras;
  int extraAmount;

  MealModel({
    this.mealType,
    this.mainFood,
    this.extras,
    this.extraAmount = 0,
  });

  static String getTranslatedMeal(MealType m) {
    switch (m) {
      case MealType.breakfast:
        return "Café da manhã";
      case MealType.lunch:
        return "Almoço";
      case MealType.snack:
        return "Lanche";
      case MealType.dinner:
        return "Jantar";
      default:
        return '';
    }
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is MealModel &&
      o.mealType == mealType &&
      o.mainFood == mainFood &&
      listEquals(o.extras, extras) &&
      o.extraAmount == extraAmount;
  }

  @override
  int get hashCode {
    return mealType.hashCode ^
      mainFood.hashCode ^
      extras.hashCode ^
      extraAmount.hashCode;
  }

  @override
  String toString() =>
      'MealModel(food: $mainFood)';

  Map<String, dynamic> toMap() {
    return {
      'mealType': mealType?.index,
      'food': mainFood?.toMap(),
      'extras': extras?.map((x) => x?.toMap())?.toList(),
      'extraAmount': extraAmount,
    };
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return MealModel(
      mealType: MealType.values[map['mealType']],
      mainFood: FoodModel.fromMap(map['food']),
      extras: List<FoodModel>.from(map['extras']?.map((x) => FoodModel.fromMap(x))),
      extraAmount: map['extraAmount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MealModel.fromJson(String source) => MealModel.fromMap(json.decode(source));
}

enum MealType {
  breakfast,
  lunch,
  snack,
  dinner,
}
