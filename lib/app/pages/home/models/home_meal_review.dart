import 'dart:convert';

import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/home_meal_model.dart';

class HomeMealReviewModel extends HomeMealModel {
  //enum
  final bool done;

  HomeMealReviewModel({
    required HomeMealModel mealCardModel,
    required this.done,
  }) : super(
          img: mealCardModel.img,
          type: mealCardModel.type,
          title: mealCardModel.title
        );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map.addAll(super.toMap());
    map['isDone'] = done;
    return map;
  }

  HomeMealReviewModel.fromMap(Map<String, dynamic> map)
      : this.done = map['isDone'],
        super.fromMap(map);

  HomeMealReviewModel.fromMealModel(MealModel meal, bool done)
      : this.done = done,
        super(img: meal.img, type: meal.type, title: meal.title);

  String toJson() => json.encode(toMap());

  factory HomeMealReviewModel.fromJson(String source) =>
      HomeMealReviewModel.fromMap(json.decode(source));
}
