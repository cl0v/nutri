
import 'dart:convert';

import 'package:nutri/app/models/meal_model.dart';

class ReviewModel {
  final MealModel meal;
  //enum
  final bool done;

  ReviewModel({
    required this.meal,
    required this.done,
  });

  Map<String, dynamic> toMap() {
    return {
      'meal': meal.toMap(),
      'isDone': done,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      meal: MealModel.fromMap(map['meal']),
      done: map['isDone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) => ReviewModel.fromMap(json.decode(source));
}
