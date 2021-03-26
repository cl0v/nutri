import 'dart:convert';

import 'package:nutri/app/models/meal_model.dart';

class ReviewModel extends MealModel {
  //enum
  final bool done;

  ReviewModel({
    img,
    type,
    day,
    required this.done,
  }) : super(
          img: img,
          meal: type,
          day: day,
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
        super(img: meal.img, meal: meal.meal, day: meal.day);

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) =>
      ReviewModel.fromMap(json.decode(source));
}
