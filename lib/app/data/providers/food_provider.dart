import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:nutri/app/data/model/food_model.dart';

const jsonPath = 'assets/jsons/food_data.json';

class FoodProvider {



/// Recebe todas as comidas cadastradas no banco

  Future<List<FoodModel>> loadAllFoods() async {
    var json = await _loadJson();
    return json.map((map) => FoodModel.fromMap(map)).toList();
  }


 ///Recebe todas as carnes cadastradas no banco

  loadMeats() => _sortJsonByCategory(FoodCategory.meat);


///Recebe todas as bebidas cadastradas no banco

  loadDrinks() => _sortJsonByCategory(FoodCategory.drink);


///Recebe todas os vegetais cadastrados no banco

  loadVegetables() => _sortJsonByCategory(FoodCategory.vegetable);


///Recebe todas as frutas cadastradas no banco

  loadFruits() => _sortJsonByCategory(FoodCategory.fruit);

  Future<List> _loadJson() async =>
      jsonDecode(await rootBundle.loadString(jsonPath));

  Future<List<FoodModel>> _sortJsonByCategory(FoodCategory category) async {
    var json = await _loadJson();
    return json
        .where((map) =>
            map['category'] == FoodModel.getIndexFromCategory(category))
        .map((map) => FoodModel.fromMap(map))
        .toList();
  }

//TODO: Implement loadFoodsFromPreferences;
  Future<List<FoodModel>> loadFoodsFromPreferences(List<String> prefs) async {
    if (prefs == null) return [];
    var json = await _loadJson();
    return json
        .where((map) => prefs.contains(map['title']))
        .map((map) => FoodModel.fromMap(map))
        .toList();
  }

}
