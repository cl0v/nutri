import 'dart:convert';

import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/meal_card_model.dart';

class ReviewModel extends MealCardModel {
  //enum
  final bool done;

  ReviewModel({
    required MealCardModel mealCardModel,
    required this.done,
  }) : super(
          img: mealCardModel.img,
          type: mealCardModel.type,
          day: mealCardModel.day,
        );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map.addAll(super.toMap());
    map['isDone'] = done;
    return map;
  }

  ReviewModel.fromMap(Map<String, dynamic> map)
      : this.done = map['isDone'],
        super.fromMap(map);

  ReviewModel.fromMealModel(MealModel meal, bool done)
      : this.done = done,
        super(img: meal.img, type: meal.type, day: meal.day);

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source));
}
