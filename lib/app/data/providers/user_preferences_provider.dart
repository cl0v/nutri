import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesProvider {
  final Future<SharedPreferences> sharedPreferences;

  UserPreferencesProvider({@required this.sharedPreferences});

  Future<Map<String, String>> getQuestionsPrefs() async {
    Map<String, String> map = Map();
    var p = await sharedPreferences;
    p.getKeys().toList().where((key) => key.contains('q_')).forEach((key) {
      map[key] = p.getString(key);
    });
    return map;
  }

  void setQuestionsPrefs(Map<String, String> answers) => answers.forEach(
      (key, value) async => (await sharedPreferences).setString(key, value));
}
