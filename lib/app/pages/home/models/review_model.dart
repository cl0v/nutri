
import 'dart:convert';

import 'package:nutri/app/pages/home/models/meal_model.dart';

class ReviewModel {
  final MealModel overviewModel;
  //enum
  final bool done;

  ReviewModel({
    required this.overviewModel,
    required this.done,
  });

  Map<String, dynamic> toMap() {
    return {
      'overviewModel': overviewModel.toMap(),
      'isDone': done,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      overviewModel: MealModel.fromMap(map['overviewModel']),
      done: map['isDone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) => ReviewModel.fromMap(json.decode(source));
}
