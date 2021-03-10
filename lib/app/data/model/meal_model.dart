import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:nutri/app/data/model/food_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return 'MealModel(mealType: $mealType)';
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

abstract class MealModelHelper {
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
}

const weeklyMealsPrefsKey = 'weeklyMeals';

abstract class MealProvider {
  //Lembrando que o toJson é uma string, logo o sqflite aceita tambem

  static List<List<MealModel>> saveWeeklyMealsOnPrefs(
      SharedPreferences prefs, List<List<MealModel>> listOfDailyMeal) {
    var list = listOfDailyMeal.map((l) => json.encode(l)).toList();
    prefs.setStringList(weeklyMealsPrefsKey, list);

    return listOfDailyMeal;
  }

  static List<List<MealModel>> getWeeklyMealsFromPrefs(
      SharedPreferences prefs) {
    var foodPrefList = prefs.getStringList(weeklyMealsPrefsKey);
    print(foodPrefList);
    if (foodPrefList != null)
      return foodPrefList?.map((w) {
        List js = json.decode(w);
        return js.map((e) => MealModel.fromJson(e)).toList();
      })?.toList();
    else
      return null;
  }
}
