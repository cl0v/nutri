import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum HomeState{
  Error,
  Ready,
  NotReady,
  WaitingFoodPrefs,
}

class HomeProvider {
  final Future<SharedPreferences> sharedPreferences;

  HomeProvider({@required this.sharedPreferences});

  getHomeState() {
    return 1;
    //Aqui é basicamente um loading, para saber o que deve ser feito depois do login
  }

  Future<List<MealModel>> fetchDailyMeals({int day = 1}) async =>
      HomeProviderHelper.fetchDailyMeals(await sharedPreferences, day: day);

  /// [fetchMealsOfTheWeek] builds the meal of the amount of days on the week
  /// with the same pattern of the daily meals
  /// Basicaly is the daily meal multiplied by 7 and randomized
  Future<List<List<MealModel>>> fetchMealsOfTheWeek() async =>
      HomeProviderHelper.fetchWeeklyMeals(await sharedPreferences);

//TODO: Salvar as refeições já confirmadas do dia
// Salvar o index de qual refeição é a proxima(Se confirmei o cafe da manha, a proxima refeição, para quando eu abrir o app, deverá ser o almoço)
// Lembrar que isso pode afetar o dia seguinte....
  saveMealPrefs(String mealType, List<String> list) async =>
      //TODO: Implement saveMealPrefs
      (await sharedPreferences).setStringList(mealType, list);
}

abstract class HomeProviderHelper {
  static int daysInAWeek = 7;
  // int dailyMealAmount = 4;

  static Future<List<List<MealModel>>> fetchWeeklyMeals(prefs) async {
    var weeklyMeals = await _getWeeklyMeals(prefs);
    if (weeklyMeals.isEmpty)
      return _buildMealsOfTheWeek(prefs);
    else
      return weeklyMeals;
  }

  static Future<List<MealModel>> fetchDailyMeals(prefs, {int day = 1}) async {
    return (await fetchWeeklyMeals(await prefs))[day - 1];
  }

  static Future<List<List<MealModel>>> _buildMealsOfTheWeek(prefs) async {
    List<List<MealModel>> listOfDailyMeal = [];
    for (var i = 1; i <= daysInAWeek; i++) {
      var dailyMeal = await _buildDailyMeal(prefs);
      listOfDailyMeal.add(dailyMeal);
    }
    await _saveWeeklyMeals(prefs, listOfDailyMeal);
    return listOfDailyMeal;
  }

  static Future<List<MealModel>> _buildDailyMeal(sharedPreferences) async {
    var foodPrefsList = await _getFoodsPrefsList(sharedPreferences);

    var breakfast = await _buildBreakfast(foodPrefsList);
    var lunch = await _buildLunch(foodPrefsList);
    var snack = await _buildSnack(foodPrefsList);
    var dinner = await _buildDinner(foodPrefsList);

    return [breakfast, lunch, snack, dinner];
  }

  static Future<List<String>> _getFoodsPrefsList(sharedPreferences) async =>
      FoodProvider.getFoodsPrefsList(sharedPreferences);

  static Future<List<List<MealModel>>> _getWeeklyMeals(
          sharedPreferences) async =>
      MealProvider.getWeeklyMealsFromPrefs(await sharedPreferences);

  static Future<List<List<MealModel>>> _saveWeeklyMeals(
          sharedPreferences, List<List<MealModel>> listOfDailyMeal) async =>
      MealProvider.saveWeeklyMealsOnPrefs(
          await sharedPreferences, listOfDailyMeal);

  static Future<MealModel> _buildDinner(List<String> prefs) async {
// IDEIA: - Priorizar vegetais de noite
    var mainFoodList =
        await FoodModelHelper.loadDinnerMainFoodsFromPrefs(prefs);
    var extraFoodList = await FoodModelHelper.loadDinnerExtrasFromPrefs(prefs);

    return MealModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: extraFoodList,
      extraAmount: 3,
      mealType: MealType.dinner,
    );
  }

  static Future<MealModel> _buildSnack(List<String> prefs) async {
    var mainFoodList = await FoodModelHelper.loadSnackMainFoodsFromPrefs(prefs);
    return MealModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: [],
      extraAmount: 0,
      mealType: MealType.snack,
    );
  }

  static Future<MealModel> _buildLunch(List<String> prefs) async {
    var mainFoodList = await FoodModelHelper.loadLunchMainFoodsFromPrefs(prefs);
    var extraFoodList = await FoodModelHelper.loadLunchExtrasFromPrefs(prefs);
    return MealModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: extraFoodList,
      extraAmount: 3,
      mealType: MealType.lunch,
    );
  }

  static Future<MealModel> _buildBreakfast(List<String> prefs) async {
    var mainFoodList =
        await FoodModelHelper.loadBreakfastMainFoodsFromPrefs(prefs);
    return MealModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: [],
      extraAmount: 0,
      mealType: MealType.breakfast,
    );
  }
}
