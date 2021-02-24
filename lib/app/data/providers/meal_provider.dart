import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

//IDEIA: Entender com o tempo as escolhar do usuario (padroes etc)
//IDEIA: Escolher a melhor forma de organizar quais alimentos deverão aparecer;

//IDEIA: Montar a lista de alimentos no final da semana
//IDEIA: Dividir 'aleatoriamente' por 7 e cada dia será um meal + 4(por dia)...;
//IDEIA: Descobrir quantas refeições a pessoa costuma fazer;

const foodPrefsKey = 'foodPrefs';

class MealProvider {
  final Future<SharedPreferences> prefs;

  MealProvider({@required this.prefs});

  int dailyMealAmount = 3;
  int daysInAWeek = 7;

  Future<List<MealModel>> fetchMeals() async {
    List<MealModel>();
    var foods = await FoodModelHelper.loadAllFoods();
    List meals = List<MealModel>();
    foods.forEach(
      (food) {
        meals.add(
          MealModel(
            food: food,
            mealType: MealType.breakfast,
            extras: foods
                .where((f) => f.category == FoodCategory.vegetable)
                .toList(),
          ),
        );
      },
    );
    _sortMealListByMealTypeOrder(meals);

    return meals.take(3).toList();
  }

  _sortMealListByMealTypeOrder(List<MealModel> m) {
    //TODO: Testar sem o retorno;
    m.sort((a, b) => a.mealType.index.compareTo(b.mealType.index));
    return m;
  }

  Future<List<List<MealModel>>> fetchMealsOfTheWeek() async {
    List<MealModel> dailyMeal = [];
    List<List<MealModel>> weekMeal = [];
    List<FoodModel> listOfMeat = await FoodModelHelper.loadMeats();
    List<FoodModel> listOfDrinks = await FoodModelHelper.loadMeats();

    dailyMeal.addAll(
        listOfDrinks.take(Random().nextInt(listOfDrinks.length)).map((drink) {
      return MealModel(food: drink, extras: [], mealType: MealType.breakfast);
    }));
    dailyMeal.addAll(listOfMeat.take(Random().nextInt(listOfMeat.length)).map(
      (meat) {
        var mealType =
            MealType.values[Random().nextInt(MealType.values.length - 3) + 3];
        return MealModel(
          food: meat,
          extras: [],
          mealType: mealType,
        );
      },
    ));

    weekMeal = List.generate(daysInAWeek, (idx) => dailyMeal);
    return weekMeal;
  }

  _addMealToMealList(){
    
  }

  Future<List<String>> getFoodsPrefs() async =>
      (await prefs).getStringList(foodPrefsKey);
}
