import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/food_swipe_model.dart';
import 'package:nutri/app/data/providers/food_swipe_provider.dart';

class FoodSwipeRepository {
  FoodSwipeProvider provider;

  FoodSwipeRepository({@required this.provider});

  Future<List<FoodSwipeModel>> loadFoodSwipeList() =>
      provider.loadFoodSwipeList();

  filterBasedOnExerciceIntensity() => provider.filterBasedOnExerciceIntensity();

  setFoodPreferences(List<String> list) => provider.setFoodsPrefs(list);
}
