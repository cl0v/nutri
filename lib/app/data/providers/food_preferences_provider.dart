import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const foodPrefsKey = 'foodPrefs';

//TODO: Estou dando a possibilidade do usuario nao salvar nenhuma comida na foodswipe (Botao de pular)
//TODO: Mark to exclude, create on every on that need it(ou criar um helper global /data/helpers/foodPreferencesHelper)
class FoodPreferencesProvider {
  final Future<SharedPreferences> sharedPreferences;

  FoodPreferencesProvider({@required this.sharedPreferences});

  Future<List<String>> getFoodsPrefs() async =>
      (await sharedPreferences).getStringList(foodPrefsKey);

  void setFoodsPrefs(List<String> foodPrefs) async =>
      (await sharedPreferences).setStringList(foodPrefsKey, foodPrefs);
}
