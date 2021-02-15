import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesProvider {
  final Future<SharedPreferences> sharedPreferences;

  UserPreferencesProvider({@required this.sharedPreferences});

  Future<Map<String, String>> getQuestionsPrefs() async {
    Map<String, String> map = Map();
    var p = await sharedPreferences;
    p.getKeys().toList().forEach((key) {
      map[key] = p.getString(key);
    });
    return map;
  }

  void setQuestionsPrefs(Map<String, String> answers) => answers.forEach(
      (key, value) async => (await sharedPreferences).setString(key, value));

  Future<Map<String, int>> getFoodsPrefs() async {
    Map<String, int> map = Map();
    var p = await sharedPreferences;
    p.getKeys().toList().forEach((key) {
      map[key] = p.getInt(key);
    });
    return map;
  }
      
  void setFoodsPrefs(Map<String, int> foodPref) => foodPref.forEach(
      (key, value) async => (await sharedPreferences).setInt(key, value));


}
