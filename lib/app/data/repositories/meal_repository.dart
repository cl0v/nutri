import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/providers/meal_provider.dart';

class MealRepository {
  final MealProvider provider;

  MealRepository({
    @required this.provider,
  });


  Future<List<List<MealModel>>> fetchDailyMenuOfTheWeek() =>
      provider.fetchMealsOfTheWeek();

  Future<List<MealModel>> fetchDailyMeals({int day = 1}) => provider.fetchDailyMeals(day: day);

  Future saveMealPrefs(String mealType, List<String> list) => provider.saveMealPrefs(mealType, list);
}
