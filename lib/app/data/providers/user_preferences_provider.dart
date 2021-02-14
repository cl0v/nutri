import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesProvider {
  final Future<SharedPreferences> prefs;

  UserPreferencesProvider({@required this.prefs});

  Future<Map<String, String>> getUserInfo() async {
    Map<String, String> map = Map();
    var p = await prefs;
    p.getKeys().toList().forEach((key) {
      map[key] = p.getString(key);
    });
    //TODO: Testar se limpar cache apaga os dados
    return map;
  }

  void setUserInfo(Map<String, String> answers) => answers
      .forEach((key, value) async => (await prefs).setString(key, value));
}
