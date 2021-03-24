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
  final MealType type;
  final String img;
  final int day;
  //TODO: Adicionar o titulo da refeição e mostrar no lugar de qual refeição será

  MealModel({
    required this.type,
    required this.img,
    this.day = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'meal': type.index,
      'img': img,
      'day': day,
    };
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      type: MealType.values[map['meal']],
      img: map['img'],
      day: map['day'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MealModel.fromJson(String source) =>
      MealModel.fromMap(json.decode(source));


      String mealTypeToString(){
        switch (type) {
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
