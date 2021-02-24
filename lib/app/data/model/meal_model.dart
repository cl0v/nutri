import 'package:flutter/foundation.dart';

import 'package:nutri/app/data/model/food_model.dart';

class MealModel {
  //enum
  MealType mealType;
  FoodModel food;
  List<FoodModel> extras;
  //Mapa de extras Lista de Food e quantidade
  
  
  MealModel({
    this.mealType,
    this.food,
    this.extras,
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
        listEquals(o.extras, extras);
  }

  @override
  int get hashCode => mealType.hashCode ^ food.hashCode ^ extras.hashCode;

  @override
  String toString() => 'MealModel(meal: $mealType, food: $food, extras: $extras)';
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
