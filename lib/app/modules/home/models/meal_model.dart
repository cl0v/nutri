import 'dart:convert';

import 'package:flutter/services.dart';

enum MealType {
  breakfast,
  lunch,
  snack,
  dinner,
}

class OverviewModel {
  //enum
  final MealType meal;
  final String img;
  final int day;

  OverviewModel({
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

  factory OverviewModel.fromMap(Map<String, dynamic> map) {
    return OverviewModel(
      meal: MealType.values[map['meal']],
      img: map['img'],
      day: map['day'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OverviewModel.fromJson(String source) =>
      OverviewModel.fromMap(json.decode(source));
}

const jsonPath = 'assets/jsons/meal.json';

abstract class MealProvider {
  static Future<List> _loadJson() async =>
      jsonDecode(await rootBundle.loadString(jsonPath));

  static Future<List<OverviewModel>> loadMealsFromJson() async {
    var json = await (_loadJson());
    return json.map((map) => OverviewModel.fromMap(map)).toList();
  }

  static Future<List<OverviewModel>> loadMealListByDay(int day) async {
    var json = await (_loadJson());
    return json
        .map((map) => OverviewModel.fromMap(map))
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
