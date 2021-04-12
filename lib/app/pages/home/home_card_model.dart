import 'dart:convert';

import 'package:nutri/app/models/meal_model.dart';

enum MealCardStatus {
  None,
  Skipped,
  Done,
}

class MealCardModel extends MealModel {
  MealCardStatus status;

  MealCardModel({
    required MealModel meal,
    required this.status,
  }) : super(
          img: meal.img,
          title: meal.title,
          type: meal.type,
        );

  factory MealCardModel.fromMealModel(MealModel mealModel) {
    return MealCardModel(meal: mealModel, status: MealCardStatus.None);
  }

  factory MealCardModel.fromMap(Map<String, dynamic> map) {
    return MealCardModel(
      meal: MealModel.fromMap(map['meal']),
      status: MealCardStatus.values[map['status']],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {'meal': super.toMap(), 'status': status.index};
  }

  factory MealCardModel.fromJson(String source) =>
      MealCardModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'MealCardModel(status: $status)';
}
