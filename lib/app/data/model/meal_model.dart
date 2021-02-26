import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:nutri/app/data/model/food_model.dart';

class MealModel {
  //enum
  MealType mealType;
  FoodModel food;
  List<FoodModel> extras;
  int extraAmount;

  MealModel({
    this.mealType,
    this.food,
    this.extras,
    this.extraAmount = 0,
  });

  static getTranslatedMeal(MealType m) {
    switch (m) {
      case MealType.breakfast:
        return "Café da manhã";
      case MealType.brunch:
        return "brunch";
      case MealType.elevenses:
        return "elevenses";
      case MealType.lunch:
        return "Almoço";
      case MealType.tea:
        return "Café da tarde";
      case MealType.supper:
        return "Jantar";
      case MealType.dinner:
        return "Jantar";

      default:
        return null;
    }
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is MealModel &&
      o.mealType == mealType &&
      o.food == food &&
      listEquals(o.extras, extras) &&
      o.extraAmount == extraAmount;
  }

  @override
  int get hashCode {
    return mealType.hashCode ^
      food.hashCode ^
      extras.hashCode ^
      extraAmount.hashCode;
  }

  @override
  String toString() =>
      'MealModel(food: $food)';

  Map<String, dynamic> toMap() {
    return {
      'mealType': mealType?.index,
      'food': food?.toMap(),
      'extras': extras?.map((x) => x?.toMap())?.toList(),
      'extraAmount': extraAmount,
    };
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return MealModel(
      mealType: MealType.values[map['mealType']],
      food: FoodModel.fromMap(map['food']),
      extras: List<FoodModel>.from(map['extras']?.map((x) => FoodModel.fromMap(x))),
      extraAmount: map['extraAmount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MealModel.fromJson(String source) => MealModel.fromMap(json.decode(source));
}

enum MealType {
  breakfast,
  brunch,
  elevenses,
  lunch,
  tea,
  supper,
  dinner,
}
