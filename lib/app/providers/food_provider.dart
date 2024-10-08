
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/models/food_model.dart';


abstract class IFoodProvider {
  Future<List<FoodModel>> loadMeats();
  Future<List<FoodModel>> loadDrinks();
  Future<List<FoodModel>> loadVegetables();
  Future<List<FoodModel>> loadLowSugarFruits();
  Future<List<FoodModel>> loadTubers();
}


class FoodProvider implements IFoodProvider{

  ///Recebe todas as carnes cadastradas no banco
  Future<List<FoodModel>> loadMeats() =>
      _sortJsonByCategory(FoodCategory.meat);

  ///Recebe todas as bebidas cadastradas no banco
  Future<List<FoodModel>> loadDrinks() =>
      _sortJsonByCategory(FoodCategory.drink);

  ///Recebe todas os vegetais cadastrados no banco
  Future<List<FoodModel>> loadVegetables() =>
      _sortJsonByCategory(FoodCategory.vegetable);

  ///Recebe todas as frutas cadastradas no banco
  Future<List<FoodModel>> loadLowSugarFruits() =>
      _sortJsonByCategory(FoodCategory.lowSugarFruits);

  ///Recebe todas os tuberculos cadastrados no banco
  Future<List<FoodModel>> loadTubers() =>
      _sortJsonByCategory(FoodCategory.tuber);


  Future<List> _loadJson() async =>
      jsonDecode(await rootBundle.loadString('assets/jsons/food_data.json'));

  Future<List<FoodModel>> _sortJsonByCategory(
      FoodCategory category) async {
    var list = (await _loadJson())
        .where((map) =>
            map['category'] == FoodModel.getIndexFromCategory(category))
        .map((map) => FoodModel.fromMap(map))
        .toList();
    list.shuffle();
    return list;
  }
}
