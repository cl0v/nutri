import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/providers/food_preferences_provider.dart';

class FoodPreferencesRepository {
  final FoodPreferencesProvider provider;

  FoodPreferencesRepository({@required this.provider});

  void setFoodsPrefs(List<String> foodPref) =>
      provider.setFoodsPrefs(foodPref);
      
  Future<List<String>> getFoodPrefs() => provider.getFoodsPrefs();
}
