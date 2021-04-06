import 'dart:convert';

import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/meal_card_model.dart';

class ReviewCardModel extends MealCardModel {
  //enum
  final bool done;

  ReviewCardModel({
    required MealCardModel mealCardModel,
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

  ReviewCardModel.fromMap(Map<String, dynamic> map)
      : this.done = map['isDone'],
        super.fromMap(map);

  ReviewCardModel.fromMealModel(MealModel meal, bool done)
      : this.done = done,
        super(img: meal.img, type: meal.type, title: meal.title);

  String toJson() => json.encode(toMap());

  factory ReviewCardModel.fromJson(String source) =>
      ReviewCardModel.fromMap(json.decode(source));
}
