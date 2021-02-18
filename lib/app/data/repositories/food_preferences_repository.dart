import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/providers/food_preferences_provider.dart';

class FoodPreferencesRepository {
  final FoodPreferencesProvider provider;

  FoodPreferencesRepository({@required this.provider});

  void setFoodsPrefs(Map<String, int> foodPref) =>
      provider.setFoodsPrefs(foodPref);
      
  getFoodPrefs() => provider.getFoodsPrefs();
}
