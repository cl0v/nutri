import 'package:nutri/app/models/meal_model.dart';

class MealCardModel extends MealModel {
  MealCardModel({
    required img,
    required type,
  }) : super(
          img: img,
          type: type,
        );

  MealCardModel.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  factory MealCardModel.fromMealModel(MealModel meal) =>
      MealCardModel(img: meal.img, type: meal.type);
}
