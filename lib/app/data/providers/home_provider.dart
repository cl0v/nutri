import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO: Salvar as refeições já confirmadas do dia
// Salvar o index de qual refeição é a proxima(Se confirmei o cafe da manha, a proxima refeição, para quando eu abrir o app, deverá ser o almoço)
// Lembrar que isso pode afetar o dia seguinte....

enum HomeState {
  Error,
  Ready,
  Loading,
  SharedPrefsNull,
}

class HomeProvider {
  final Future<SharedPreferences> sharedPreferences;

  HomeProvider({@required this.sharedPreferences});

  Stream<HomeState> getHomeState() => homeStateOutput;
  closeHomeStream() => homeStateController.close();

  Future<List<MealModel>> fetchDailyMeals({int day = 1}) async =>
      _fetchDailyMeals(await sharedPreferences, day: day);

  Future<List<List<MealModel>>> fetchMealsOfTheWeek() async =>
      _fetchWeeklyMeals(await sharedPreferences);

  // saveMealPrefs(String mealType, List<String> list) async =>
  //     //TODO: Implement saveMealPrefs
  //     (await sharedPreferences).setStringList(mealType, list);

   int daysInAWeek = 7;
  // int dailyMealAmount = 4;

   BehaviorSubject<HomeState> homeStateController =
      BehaviorSubject.seeded(HomeState.Loading);
   Stream<HomeState> get homeStateOutput => homeStateController.stream;
   Sink<HomeState> get homeStateInput => homeStateController.sink;

   Future<List<List<MealModel>>> _fetchWeeklyMeals(
      sharedPreferences) async {
    List foodPrefs = _getFoodPrefs(sharedPreferences);
    if (foodPrefs == null || foodPrefs.isEmpty) {
      homeStateInput.add(HomeState.SharedPrefsNull);
      return [];
    } else {
      var weeklyMeals = _getWeeklyMeals(sharedPreferences);
      homeStateInput.add(HomeState.Ready);
      if (weeklyMeals.isEmpty)
        return _buildMealsOfTheWeek(sharedPreferences);
      else
        return weeklyMeals;
    }
  }

   Future<List<MealModel>> _fetchDailyMeals(sharedPreferences,
      {int day = 1}) async {
    var weeklyMeals = await _fetchWeeklyMeals(sharedPreferences);
    if (weeklyMeals != null && weeklyMeals.isNotEmpty)
      return weeklyMeals[day - 1];
    return [];
  }

   Future<List<List<MealModel>>> _buildMealsOfTheWeek(
      sharedPreferences) async {
    List<List<MealModel>> listOfDailyMeal = [];
    for (var i = 1; i <= daysInAWeek; i++) {
      var dailyMeal = await _buildDailyMeal(sharedPreferences);
      listOfDailyMeal.add(dailyMeal);
    }
    await _saveWeeklyMeals(sharedPreferences, listOfDailyMeal);
    return listOfDailyMeal;
  }

   Future<List<MealModel>> _buildDailyMeal(sharedPreferences) async {
    var breakfast = await MealProviderHelper.buildBreakfast(sharedPreferences);
    var lunch = await MealProviderHelper.buildLunch(sharedPreferences);
    var snack = await MealProviderHelper.buildSnack(sharedPreferences);
    var dinner = await MealProviderHelper.buildDinner(sharedPreferences);

    return [breakfast, lunch, snack, dinner];
  }

   _getFoodPrefs(sharedPreferences) =>
      FoodProvider.getFoodsPrefsList(sharedPreferences);

   List<List<MealModel>> _getWeeklyMeals(sharedPreferences) =>
      MealProvider.getWeeklyMealsFromPrefs(sharedPreferences);

   Future<List<List<MealModel>>> _saveWeeklyMeals(
          sharedPreferences, List<List<MealModel>> listOfDailyMeal) async =>
      MealProvider.saveWeeklyMealsOnPrefs(
          await sharedPreferences, listOfDailyMeal);
}
