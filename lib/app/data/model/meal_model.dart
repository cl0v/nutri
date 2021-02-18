import 'package:flutter/foundation.dart';

import 'package:nutri/app/data/model/extra_model.dart';
import 'package:nutri/app/data/model/food_model.dart';

class MealModel {

  //enum
  MealType meal;
  FoodModel food; //TODO: BUG: Como o mealModel pede um foodmodel, nao posso colocar cafe, nem bebidas *
  List<ExtraModel> extras;
  //TODO:ADD Numero de acompanhamentos... para aquela refeiçao? (Ex: escolha ate 3 acompanhamentos)

  MealModel({
    this.meal,
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
      o.meal == meal &&
      o.food == food &&
      listEquals(o.extras, extras);
  }

  @override
  int get hashCode => meal.hashCode ^ food.hashCode ^ extras.hashCode;

  @override
  String toString() => 'MealModel(meal: $meal, food: $food, extras: $extras)';
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
