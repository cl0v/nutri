import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodPreferencesProvider {
  final Future<SharedPreferences> sharedPreferences;

  FoodPreferencesProvider({@required this.sharedPreferences});

  Future<Map<String, int>> getFoodsPrefs() async {
    Map<String, int> map = Map<String, int>();
    var p = await sharedPreferences;
    p.getKeys().toList().where((key) => !key.contains('q_')).forEach((key) {
      if (p.containsKey(key)) {
        map[key] = p.getInt(key);
      }
    });
    return map;
  }

  void setFoodsPrefs(Map<String, int> foodPref) => foodPref.forEach(
      (key, value) async => (await sharedPreferences).setInt(key, value)); 
}
