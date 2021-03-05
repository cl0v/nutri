import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
// IDEIA: - Priorizar vegetais de noite

// A classe provider deverá receber os dados do banco e entregar de forma organizada
// A adicao de meal não é feita pelo usuário, é uma rotina padrao do aplicativo

const foodPrefsKey = 'foodPrefs';

class MealProvider {
  final Future<SharedPreferences> sharedPreferences;

  MealProvider({@required this.sharedPreferences});

  int dailyMealAmount = 4;
  int daysInAWeek = 7;

  Future<List<MealModel>> fetchDailyMeals({int day = 1}) async {
    // var listOfFood = await _getPossibleFoodList();
    return (await fetchMealsOfTheWeek())[day - 1];
  }

  Future<List<FoodModel>> getExtras() async {
    return await FoodModelHelper.loadVegetables();
  }

  _sortMealListByMealTypeOrder(List<MealModel> m) {
    m.sort((a, b) => a.mealType.index.compareTo(b.mealType.index));
  }

  /// [fetchMealsOfTheWeek] builds the meal of the amount of days on the week
  /// with the same pattern of the daily meals
  /// Basicaly is the daily meal multiplied by 7 and randomized
  Future<List<List<MealModel>>> fetchMealsOfTheWeek() async {
    var foodPrefsList = await _getFoodsPrefsList();
    List<List<MealModel>> listOfDailyMeal = [];
    for (var i = 1; i <= daysInAWeek; i++) {
      var dailyMeal = await _buildDailyMeal(foodPrefsList);
      listOfDailyMeal.add(dailyMeal);
    }
    return listOfDailyMeal;
  }

  //Esse cara precisa ser buildado uma vez por semana
  //logo apos o food swipe ter sido escolhido

  // Conferir se ja existem alimentos nas shared prefs, caso contrario, leva a pessoa pro food swipe
  // Ter um tempo de load para buildar as comidas, mostrar o lead na home, antes de qualquer coisa
  _buildMealsOfTheWeek() {
    // - getMealsFromDB if null build meals of the week
    // -
    //Esse cara deve buildar as comidas da semana toda e ainda salvar em algum lugar,
    // para que sempre que chamado, seja iguais os valores
    // A questao é, como salvar esses valores?
  }

  ///Esse cara recebe todos os alimentos recebidos das preferencias e randomiza
  ///as escolha de qual comida comer
  Future<List<MealModel>> _buildDailyMeal(List<String> prefs,
      {int day = 1}) async {
    var breakfast = await MealProviderHelper.buildBreakfast(prefs);
    var lunch = await MealProviderHelper.buildLunch(prefs);
    var snack = await MealProviderHelper.buildSnack(prefs);
    var dinner = await MealProviderHelper.buildDinner(prefs);

    return [breakfast, lunch, snack, dinner];
  }

  Future<List<String>> _getFoodsPrefsList() async =>
      (await sharedPreferences).getStringList(foodPrefsKey);

  saveMealPrefs(String mealType, List<String> list) async {
    //TODO: Implement saveMealPrefs
    (await sharedPreferences).setStringList(mealType, list);
  }
}

abstract class MealProviderHelper {
  static Future<MealModel> buildDinner(List<String> prefs) async {
    var mainFoodList = await FoodModelHelper.loadDinnerMainFoodsFromPrefs(prefs);
    var extraFoodList = await FoodModelHelper.loadDinnerExtrasFromPrefs(prefs);

    return MealModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: extraFoodList,
      extraAmount: 3, //TODO: Decidir a quantidade de extras
      mealType: MealType.dinner,
    );
  }

  static Future<MealModel> buildSnack(List<String> prefs) async {
    var mainFoodList = await FoodModelHelper.loadSnackMainFoodsFromPrefs(prefs);
    return MealModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: [],
      extraAmount: 5, //TODO: Decidir a quantidade de extras
      mealType: MealType.snack,
    );
  }

  static Future<MealModel> buildLunch(List<String> prefs) async {
    var mainFoodList = await FoodModelHelper.loadLunchMainFoodsFromPrefs(prefs);
    var extraFoodList = await FoodModelHelper.loadLunchExtrasFromPrefs(prefs);
    return MealModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: extraFoodList,
      extraAmount: 3, //TODO: Decidir a quantidade de extras
      mealType: MealType.lunch,
    );
  }

  static Future<MealModel> buildBreakfast(List<String> prefs) async {
    //TODO: Renomear para pegar apenas as comidas possiveis no café da manha FoodModelHelper.loadBreakfastMainFoods
    var mainFoodList = await FoodModelHelper.loadBreakfastMainFoodsFromPrefs(prefs);
    return MealModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: [],
      extraAmount: 0, //TODO: Decidir a quantidade de extras
      mealType: MealType.breakfast,
    );
  }
}
