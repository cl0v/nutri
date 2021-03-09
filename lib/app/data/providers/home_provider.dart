import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
// IDEIA: - Priorizar vegetais de noite

// A classe provider deverá receber os dados do banco e entregar de forma organizada
// A adicao de meal não é feita pelo usuário, é uma rotina padrao do aplicativo

// const foodPrefsKey = 'foodPrefs';

class HomeProvider {
  final Future<SharedPreferences> sharedPreferences;

  HomeProvider({@required this.sharedPreferences});

  int dailyMealAmount = 4;

  Future<List<MealModel>> fetchDailyMeals({int day = 1}) async {
    return (await HomeProviderHelper.fetchWeeklyMeals(
        await sharedPreferences))[day - 1];
  }

/// [fetchMealsOfTheWeek] builds the meal of the amount of days on the week
  /// with the same pattern of the daily meals
  /// Basicaly is the daily meal multiplied by 7 and randomized
  Future<List<List<MealModel>>> fetchMealsOfTheWeek() async =>
      HomeProviderHelper.fetchWeeklyMeals(await sharedPreferences);


  // _sortMealListByMealTypeOrder(List<MealModel> m) {
  //   m.sort((a, b) => a.mealType.index.compareTo(b.mealType.index));
  // }

  
  //IDEIA:Esse cara precisa ser buildado uma vez por semana
  //logo apos o food swipe ter sido escolhido

  //Quando o food swipe terminar, ele pegará todos os alimentos e irá montar um cardápio semanal
  //

  // Conferir se ja existem alimentos nas shared prefs, caso contrario, leva a pessoa pro food swipe
  // Ter um tempo de load para buildar as comidas, mostrar o lead na home, antes de qualquer coisa

  saveMealPrefs(String mealType, List<String> list) async {
    //TODO: Implement saveMealPrefs
    (await sharedPreferences).setStringList(mealType, list);
  }

  ///Esse cara recebe todos os alimentos recebidos das preferencias e randomiza
  ///as escolha de qual comida comer

}

abstract class HomeProviderHelper {

  static int daysInAWeek = 7;

  static Future<List<List<MealModel>>> buildMealsOfTheWeek(
      prefs) async {
    List<List<MealModel>> listOfDailyMeal = [];
    for (var i = 1; i <= daysInAWeek; i++) {
      var dailyMeal = await buildDailyMeal(prefs);
      listOfDailyMeal.add(dailyMeal);
    }
    //TODO: Save the week
    await saveWeeklyMeals(prefs, listOfDailyMeal);
    return listOfDailyMeal;
    // - getMealsFromDB if null build meals of the week
    // -
    //Esse cara deve buildar as comidas da semana toda e ainda salvar em algum lugar,
    // para que sempre que chamado, seja iguais os valores
    // A questao é, como salvar esses valores?
  }

  static Future<List<List<MealModel>>> fetchWeeklyMeals(
      prefs) async {
    //TODO: Tornar ternario
    var weeklyMeals = await getWeeklyMeals(prefs);
    if (weeklyMeals.isEmpty)
      return HomeProviderHelper.buildMealsOfTheWeek(prefs);
    else
      return weeklyMeals;
  }

  static Future<List<MealModel>> buildDailyMeal(sharedPreferences) async {
    var foodPrefsList = await getFoodsPrefsList(sharedPreferences);

    var breakfast = await HomeProviderHelper.buildBreakfast(foodPrefsList);
    var lunch = await HomeProviderHelper.buildLunch(foodPrefsList);
    var snack = await HomeProviderHelper.buildSnack(foodPrefsList);
    var dinner = await HomeProviderHelper.buildDinner(foodPrefsList);

    return [breakfast, lunch, snack, dinner];
  }

  static Future<List<String>> getFoodsPrefsList(sharedPreferences) async =>
      FoodProvider.getFoodsPrefsList(sharedPreferences);

  static Future<List<List<MealModel>>> getWeeklyMeals(
          sharedPreferences) async =>
      MealProvider.getWeeklyMeals(await sharedPreferences);

  static Future<List<List<MealModel>>> saveWeeklyMeals(
          sharedPreferences, List<List<MealModel>> listOfDailyMeal) async =>
      MealProvider.saveWeeklyMeals(await sharedPreferences, listOfDailyMeal);

  static Future<MealModel> buildDinner(List<String> prefs) async {
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

  static Future<MealModel> buildSnack(List<String> prefs) async {
    var mainFoodList = await FoodModelHelper.loadSnackMainFoodsFromPrefs(prefs);
    return MealModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: [],
      extraAmount: 0,
      mealType: MealType.snack,
    );
  }

  static Future<MealModel> buildLunch(List<String> prefs) async {
    var mainFoodList = await FoodModelHelper.loadLunchMainFoodsFromPrefs(prefs);
    var extraFoodList = await FoodModelHelper.loadLunchExtrasFromPrefs(prefs);
    return MealModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: extraFoodList,
      extraAmount: 3,
      mealType: MealType.lunch,
    );
  }

  static Future<MealModel> buildBreakfast(List<String> prefs) async {
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
