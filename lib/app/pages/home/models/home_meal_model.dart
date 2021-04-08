import 'package:nutri/app/models/meal_model.dart';

class HomeMealModel extends MealModel {
  HomeMealModel({
    required img,
    required type,
    required title,
  }) : super(
          img: img,
          type: type,
          title: title,
        );

  HomeMealModel.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  factory HomeMealModel.fromMealModel(MealModel meal) =>
      HomeMealModel(img: meal.img, type: meal.type, title: meal.title);
}
