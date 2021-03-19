import 'dart:convert';

import 'package:flutter/services.dart';

enum MealType {
  breakfast,
  lunch,
  snack,
  dinner,
}

class MealModel {
  //enum
  final MealType meal;
  final String img;
  final int day;

  MealModel({
    required this.meal,
    required this.img,
    this.day = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'meal': meal.index,
      'img': img,
      'day': day,
    };
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      meal: MealType.values[map['meal']],
      img: map['img'],
      day: map['day'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MealModel.fromJson(String source) =>
      MealModel.fromMap(json.decode(source));
}

const jsonPath = 'assets/jsons/meal.json';

abstract class MealProvider {
  static Future<List> _loadJson() async =>
      jsonDecode(await rootBundle.loadString(jsonPath));

  static Future<List<MealModel>> loadMealsFromJson() async {
    var json = await (_loadJson());
    return json.map((map) => MealModel.fromMap(map)).toList();
  }

  static Future<List<MealModel>> loadMealListByDay(int day) async {
    var json = await (_loadJson());
    return json
        .map((map) => MealModel.fromMap(map))
        .where((meal) => meal.day == day)
        .toList();
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
