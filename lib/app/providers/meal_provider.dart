import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/models/meal_model.dart';

abstract class IMealProvider {
  @Deprecated('Não será mais usado o banco de dados dentro do provider, apenas json')
  Future<MealModel> fetchMeal(String day, MealType mealType);
  Future<MealModel> fetchMealByType(MealType type); //TODO: Usar esse
}

//TODO: Pensar se devo implementar esse carinha
//Será responsável por buildar os meals, e a ordem de cada
abstract class IDietMealBuilder {
  Future requestMeal(MealType type);
  Future buildMeals();
}

//TODO: Esse cara terá que remover o storage...
// Quem vai salvar os dados é o home viewmodel

class MealProvider implements IMealProvider {
  final ILocalStorage storage;

  MealProvider({
    required this.storage,
  });

  @override
  Future<MealModel> fetchMealByType(MealType type) async{
    var json = await _loadJson();
    var list = json.map((map) => MealModel.fromMap(map)).toList()..shuffle();
    return list.firstWhere((element) => element.type == type);
  }

  Future<MealModel> fetchMeal(day, type) async {
    var json = await storage.get('$day/${type.toString()}');
    if (json != null) return MealModel.fromJson(json);
    await _buildMeal(day, type);
    json = await storage.get('$day/${type.toString()}');
    return MealModel.fromJson(json);
  }

  _buildMeal(String day, MealType type) async {
    var json = await _loadJson();
    var list = json.map((map) => MealModel.fromMap(map)).toList()..shuffle();
    var meal = list.firstWhere((element) => element.type == type);
    await storage.put('$day/${type.toString()}', meal.toJson());
  }

  Future<List> _loadJson() async =>
      jsonDecode(await rootBundle.loadString('assets/jsons/meal.json'));
}
