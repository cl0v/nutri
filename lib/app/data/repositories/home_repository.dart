import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/providers/home_provider.dart';

class HomeRepository {
  final HomeProvider provider;

  HomeRepository({
    required this.provider,
  });

  Future<List<List<MealModel>>> fetchDailyMenuOfTheWeek() =>
      provider.fetchMealsOfTheWeek();

  getHomeState() => provider.getHomeState();
  closeHomeStream() => provider.closeHomeStream();

  Future<List<MealModel>> fetchDailyMeals({int day = 1}) =>
      provider.fetchDailyMeals(day: day);

  Future<int> getPageIndex(int day) => provider.getPageIndexFromPrefs(day);
  void setPageIndex(int pageIdx, int day) => provider.setPageIndexOnPrefs(pageIdx, day);

  // Future saveMealPrefs(String mealType, List<String> list) =>
  // provider.saveMealPrefs(mealType, list);
}
