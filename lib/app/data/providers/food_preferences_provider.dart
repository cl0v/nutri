import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const foodPrefsKey = 'foodPrefs';

class FoodPreferencesProvider {
  final Future<SharedPreferences> sharedPreferences;

  FoodPreferencesProvider({@required this.sharedPreferences});

  //TODO: Nao vou mais salvar a nota, vou salvar a comida, por enquanto, ja que dou a possibilidade de a pessoa trocar na home, nao preciso sortear com base na preferencia

  Future<List<String>> getFoodsPrefs() async =>
      (await sharedPreferences).getStringList(foodPrefsKey);

  void setFoodsPrefs(List<String> foodPrefs) async =>
      (await sharedPreferences).setStringList(foodPrefsKey, foodPrefs);
  //TODO: Implement setFoodsPrefs
}
