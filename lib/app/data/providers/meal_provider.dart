import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

//IDEIA: Entender com o tempo as escolhar do usuario (padroes etc)

//INFO: Frutas so de noite ou antes da atividade fisica
//IDEIA: Em algum momento terei que botar peso nos alimentos(Para decidir a frequencia com que cada um apareça)

const foodPrefsKey = 'foodPrefs';

class MealProvider {
  final Future<SharedPreferences> prefs;

  MealProvider({@required this.prefs});

  int dailyMealAmount = 4;
  int daysInAWeek = 7;

  Future<List<MealModel>> fetchDailyMeals() async {
    var listOfFood = await _getPossibleFoodList();
    return _buildDailyMeal(listOfFood);
  }

  Future<List<MealModel>> fetchMeals() async {
    print(await _getFoodsPrefs());
    var foods = await FoodModelHelper.loadAllFoods();
    List meals = List<MealModel>();
    foods.forEach(
      (food) {
        meals.add(
          MealModel(
            mainFood: food,
            mealType: MealType.breakfast,
            extras: foods
                .where((f) => f.category == FoodCategory.vegetable)
                .toList(),
          ),
        );
      },
    );

    var mealsOfTheWeek = await fetchMealsOfTheWeek();
    mealsOfTheWeek.shuffle();
    var dailyMeal = mealsOfTheWeek.take(1).first.toList();
    _sortMealListByMealTypeOrder(dailyMeal);

    return dailyMeal;
  }

  _sortMealListByMealTypeOrder(List<MealModel> m) {
    m.sort((a, b) => a.mealType.index.compareTo(b.mealType.index));
  }

  Future<List<List<MealModel>>> fetchMealsOfTheWeek() async {
    var listOfFood = await _getPossibleFoodList();
    List<List<MealModel>> listOfDailyMeal = [];
    for (var i = 0; i < daysInAWeek; i++) {
      var dailyMeal = await _buildDailyMeal(listOfFood);
      listOfDailyMeal.add(dailyMeal);
    }
    return listOfDailyMeal;
  }

  ///Filtra a lista de comida para saber as possibilidades
  Future<List<List<FoodModel>>> _getPossibleFoodList() async {
    var prefsList = await _getFoodsPrefs();
    List<FoodModel> listOfDrinks =
        await FoodModelHelper.loadPrefsDrinks(prefsList);
    List<FoodModel> listOfMeat =
        await FoodModelHelper.loadPrefsMeats(prefsList);
    List<FoodModel> listOfVegetables =
        await FoodModelHelper.loadPrefsVegetables(prefsList);
    List<FoodModel> listOfEggs = await FoodModelHelper.loadEggs();

    return [
      listOfDrinks,
      listOfMeat,
      listOfVegetables,
      listOfEggs,
    ];
  }

//FIXME: A Aleatoriedade pode as vezes pegar uma unica carne, cerca de 30% de sorte pra o error acontecer
  ///Esse cara recebe todos os alimentos e randomiza as escolha de qual comida comer
  Future<List<MealModel>> _buildDailyMeal(
      List<List<FoodModel>> listOfFood) async {
    List<FoodModel> listOfDrinks = listOfFood[0];
    List<FoodModel> listOfMeat = listOfFood[1];
    List<FoodModel> listOfVegetables = listOfFood[2];
    List<FoodModel> listOfEggs = listOfFood[3];

//Quantidade de extras deverá ser decidida de maneira mais inteligente
    var breakfast = _buildBreakfast(listOfDrinks);
    var lunch = _buildLunch(listOfMeat, listOfVegetables);
    var snack = _buildSnack(listOfEggs);
    var dinner = _buildDinner(listOfMeat, listOfVegetables);

    return [breakfast, lunch, snack, dinner];
  }

  MealModel _buildDinner(
      List<FoodModel> listOfFood, List<FoodModel> listOfExtras) => MealModel(
      mainFood: listOfFood[Random().nextInt(listOfFood.length)],
      extras: listOfExtras,
      extraAmount: 3,
      mealType: MealType.dinner,
    );

  // MealModel _buildFruitMeal(
  //     List<FoodModel> mainFruitCard, List<FoodModel> listOfExtra) => MealModel(
  //     mainFood: mainFruitCard.first, //Deve receber apenas o card de fruta
  //     extras: listOfExtra,
  //     extraAmount: 1,
  //     mealType: MealType.dinner,
  //   );

  MealModel _buildSnack(List<FoodModel> listOfFood) => MealModel(
      mainFood: listOfFood.first,
      extras: [],
      extraAmount: 5,
      mealType: MealType.snack,
    );

  MealModel _buildLunch(
      List<FoodModel> listOfFood, List<FoodModel> listOfExtra) => MealModel(
      mainFood: listOfFood[Random().nextInt(listOfFood.length)],
      extras: listOfExtra,
      extraAmount: 3,
      mealType: MealType.lunch,
    );

  MealModel _buildBreakfast(List<FoodModel> listOfFood) => MealModel(
      mainFood: listOfFood[Random().nextInt(listOfFood.length)],
      extras: [],
      extraAmount: 0,
      mealType: MealType.breakfast,
    );

  Future<List<String>> _getFoodsPrefs() async =>
      (await prefs).getStringList(foodPrefsKey);
}
