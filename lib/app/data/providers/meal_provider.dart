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

//FIXME: Remover o refrigerante sem açucar da lista, pelo menos por agora

//BUG: Quando a pessoa nao escolhe nenhuma comida no foodSwipe o app trava
//FIXME: Obrigar a pessoa a escolher pelo menos uma carne e uma bebida(!nao precisa tanto) no food swipe

const foodPrefsKey = 'foodPrefs';

class MealProvider {
  final Future<SharedPreferences> prefs;

  MealProvider({@required this.prefs});

  int dailyMealAmount = 4; //4 contando com o cafe da manha
  int daysInAWeek = 7;

  Future<List<MealModel>> fetchMeals() async {
    print(await _getFoodsPrefs());
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
    List<FoodModel> listOfMeat = await FoodModelHelper.loadMeats();
    List<FoodModel> listOfDrinks = await FoodModelHelper.loadDrinks();
    List<FoodModel> listOfFruits = await FoodModelHelper.loadFruits();
    List<FoodModel> listOfVegetables = await FoodModelHelper.loadVegetables();

    listOfMeat = await _getPossibleMeals(listOfMeat);
    listOfDrinks = await _getPossibleMeals(listOfDrinks);
    listOfFruits = await _getPossibleMeals(listOfFruits);
    listOfVegetables = await _getPossibleMeals(listOfVegetables);

    List<List<MealModel>> weekMeal = [];

    weekMeal = List.generate(daysInAWeek,
        (idx) => _buildDailyMeal(listOfDrinks, listOfMeat, listOfVegetables, listOfFruits));
    return weekMeal;
  }

  ///Filtra a lista de comida para saber as possibilidades
  _getPossibleMeals(List<FoodModel> listOfFood) async {
    var prefsList = await _getFoodsPrefs();
    return listOfFood.where((food) => prefsList.contains(food.title)).toList();
  }

  //FIXME: A Aleatoriedade pode as vezes pegar uma unica carne, cerca de 30% de sorte pra o error acontecer
//Esse cara recebe todos os alimentos e randomiza as escolha de qual comida comer
//Da forma que tá, a lista final receberá sempre a mesma diaria
  List<MealModel> _buildDailyMeal(
    List<FoodModel> listOfDrinks,
    List<FoodModel> listOfMeat,
    List<FoodModel> listOfVegetables,
    List<FoodModel> listOfFruits,
  ) {
    var drinkAmount = listOfDrinks.length;
    var meatAmount = listOfMeat.length;

    var breakfast = MealModel(
        food: listOfDrinks[Random().nextInt(drinkAmount)],
        extras: [],
        mealType: MealType.breakfast);
    var lunch = MealModel(
        food: listOfMeat[Random().nextInt(meatAmount)],
        extras: listOfVegetables,
        mealType: MealType.lunch);
    var tea = MealModel(
        food: listOfMeat[Random().nextInt(meatAmount)],
        extras: [],
        mealType: MealType.tea);
    var dinner = MealModel(
        food: listOfMeat[Random().nextInt(meatAmount)],
        extras: listOfFruits,
        mealType: MealType.dinner);

    return [breakfast, lunch, tea, dinner];
  }

  Future<List<String>> _getFoodsPrefs() async =>
      (await prefs).getStringList(foodPrefsKey);
}
