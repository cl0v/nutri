import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/interfaces/providers/diet_interface.dart';
import 'package:nutri/app/modelhelpers/food_modelhelper.dart';
import 'package:nutri/app/models/diet_model.dart';
import 'package:nutri/app/models/meal_model.dart';

class DefaultPeDietProvider extends IDiet {
  Future<MealModel> _fetchMealModel(day, idx) async {
    var json =
        await jsonDecode(await rootBundle.loadString('assets/jsons/meal.json'))
            as List;
    //TODO: Renomear o json para default_pe_diet

    return json
        .map((map) => MealModel.fromMap(map))
        .where((meal) => meal.day == day)
        .toList()[idx];
  }

  @override
  Future<DietModel> getBreakfast(day) async {
    var meal = await _fetchMealModel(day, 0);
    var mainFoodList = await FoodModelHelper().loadDrinks();
    return DietModel(
      meal: meal,
      mainFoodList: mainFoodList,
      extraFoodList: [],
    );
  }

  @override
  Future<DietModel> getLunch(int day) async {
    var meal = await _fetchMealModel(day, 1);
    var mainFoodList = await FoodModelHelper().loadMeats();
    var extraFoodList = await FoodModelHelper().loadVegetables();
    return DietModel(
      meal: meal,
      mainFoodList: mainFoodList,
      extraFoodList: extraFoodList.take(6).toList(),
    );
  }

  @override
  Future<DietModel> getSnack(int day) async {
    var meal = await _fetchMealModel(day, 2);
    // var mainFoodList = await FoodModelHelper().loadMeats();
    return DietModel(
      meal: meal,
      mainFoodList: [],
      extraFoodList: [],
    );
  }

  @override
  Future<DietModel> getDinner(int day) async {
    var meal = await _fetchMealModel(day, 3);
    var mainFoodList = await FoodModelHelper().loadMeats();
    var extraFoodList = await FoodModelHelper().loadVegetables();
    return DietModel(
      meal: meal,
      mainFoodList: mainFoodList,
      extraFoodList: extraFoodList.take(6).toList(),
    );
  }
}
