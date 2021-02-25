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

//IDEIA: Frutas so de noite ou antes da atividade fisica
//IDEIA: Em algum momento terei que botar peso nos alimentos(Para decidir a frequencia com que cada um apareça)

//BUG: Quando a pessoa nao escolhe nenhuma comida no foodSwipe o app trava
//FIXME: Obrigar a pessoa a escolher pelo menos uma carne e uma bebida(!nao precisa tanto) no food swipe

//TODO: Vou precisar testar o card de frutas principal, pode ser que o codigo ainda nao saiba quando é main ou extra

const foodPrefsKey = 'foodPrefs';

class MealProvider {
  final Future<SharedPreferences> prefs;

  MealProvider({@required this.prefs});

  int dailyMealAmount = 4; //4 contando com o cafe da manha
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
            food: food,
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
    return List.generate(daysInAWeek, (idx) => _buildDailyMeal(listOfFood));
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
    List<FoodModel> listOfFruits =
        await FoodModelHelper.loadPrefsFruits(prefsList);
    // List<FoodModel> listOfMeat = await FoodModelHelper.loadMeats();
    // List<FoodModel> listOfVegetables = await FoodModelHelper.loadVegetables();
    // List<FoodModel> listOfFruits = await FoodModelHelper.loadFruits();

    var listOfListOfPossibleFood = [
      listOfDrinks,
      listOfMeat,
      listOfVegetables,
      listOfFruits,
    ];

    return listOfListOfPossibleFood;
    // .map((listOfFood) =>
    //     listOfFood.where((food) => prefsList.contains(food.title)).toList())
    // .toList();
  }

  //  _sortFoodsByFoodCategory(List<FoodModel> m) {
  //   m.sort((a, b) => a.mealType.index.compareTo(b.mealType.index));
  // }

  //FIXME: A Aleatoriedade pode as vezes pegar uma unica carne, cerca de 30% de sorte pra o error acontecer
//Esse cara recebe todos os alimentos e randomiza as escolha de qual comida comer
//Da forma que tá, a lista final receberá sempre a mesma diaria
  List<MealModel> _buildDailyMeal(List<List<FoodModel>> listOfFood) {
    List<FoodModel> listOfDrinks = listOfFood[0];
    List<FoodModel> listOfMeat = listOfFood[1];
    List<FoodModel> listOfVegetables = listOfFood[2];
    List<FoodModel> listOfFruits = listOfFood[3];

    var drinkAmount = listOfDrinks.length;
    var meatAmount = listOfMeat.length;

    //BUG: Quando uma carne, fruta ou bebida(pelo menos um de cada) nao é escolhida, o app trava(ja que estou usando o list[VAL] no build e esse val n pode ser nulo)

    var breakfast = MealModel(
      food: listOfDrinks[Random().nextInt(drinkAmount)],
      extras: [],
      mealType: MealType.breakfast,
    );
    var lunch = MealModel(
      food: listOfMeat[Random().nextInt(meatAmount)],
      extras: listOfVegetables,
      mealType: MealType.lunch,
    );
    var tea = MealModel(
      food: listOfMeat[Random().nextInt(meatAmount)],
      extras: listOfVegetables,
      mealType: MealType.tea,
    );
    var dinner = MealModel(
      food: listOfFruits.first,
      extras: listOfFruits,
      mealType: MealType.dinner,
    );

    return [breakfast, lunch, tea, dinner];
  }

  Future<List<String>> _getFoodsPrefs() async =>
      (await prefs).getStringList(foodPrefsKey);
}
