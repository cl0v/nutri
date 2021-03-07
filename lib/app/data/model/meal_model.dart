import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:nutri/app/data/model/food_model.dart';


enum MealType {
  breakfast,
  lunch,
  snack,
  dinner,
}

class MealModel {
  //enum
  MealType mealType;
  List<FoodModel> mainFoodList;
  List<FoodModel> extraList;
  int extraAmount;

  MealModel({
    this.mealType,
    this.mainFoodList,
    this.extraList,
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

  Map<String, dynamic> toMap() {
    return {
      'mealType': mealType?.index,
      'mainFoodList': mainFoodList?.map((x) => x?.toMap())?.toList(),
      'extras': extraList?.map((x) => x?.toMap())?.toList(),
      'extraAmount': extraAmount,
    };
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MealModel(
      mealType: MealType.values[map['mealType']],
      mainFoodList: List<FoodModel>.from(
          map['mainFoodList']?.map((x) => FoodModel.fromMap(x))),
      extraList:
          List<FoodModel>.from(map['extras']?.map((x) => FoodModel.fromMap(x))),
      extraAmount: map['extraAmount'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MealModel.fromJson(String source) =>
      MealModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MealModel(mealType: $mealType, mainFoodList: $mainFoodList)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MealModel &&
        o.mealType == mealType &&
        listEquals(o.mainFoodList, mainFoodList) &&
        listEquals(o.extraList, extraList) &&
        o.extraAmount == extraAmount;
  }

  @override
  int get hashCode {
    return mealType.hashCode ^
        mainFoodList.hashCode ^
        extraList.hashCode ^
        extraAmount.hashCode;
  }
}


abstract class MealProvider{


  //LEmbrando que o toJson é uma string, logo o sqflite aceita tambem

  static saveWeeklyMeals(){
    //salvar nas prefs c tojson
  }

  static List<List<MealModel>> getWeeklyMeals(){
    //Posso salvar apenas uma lista de prefs no banco de dados com o titulo da lista de comidas principais
    //Posso salvar apenas uma lista(String) de titulos dos extras


  }
}