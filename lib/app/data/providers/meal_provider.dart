import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

//IDEIA: Entender com o tempo as escolhar do usuario (padroes etc)

const foodPrefsKey = 'foodPrefs';

class MealProvider {
  final Future<SharedPreferences> prefs;

  MealProvider({@required this.prefs});

  int dailyMealAmount = 4;
  int daysInAWeek = 7;

  Future<List<MealModel>> fetchDailyMeals({int dayOfTheWeek = 0}) async {
    //TODO: [dayOfTheWeek] Receber o dia busca algum dia em específico, para a pessoa se preparar com antecedencia caso precise
    var listOfFood = await _getPossibleFoodList();
    return _buildDailyMeal(listOfFood);
  }

  Future<List<FoodModel>> getTreeFoods() async {
    return (await FoodModelHelper.loadMeats()).take(3).toList();
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
    return MealProviderHelper.getPossibleFoodList(prefsList);
  }

//FIXME: A Aleatoriedade pode as vezes pegar uma unica carne, cerca de 30% de sorte pra o error acontecer
  ///Esse cara recebe todos os alimentos e randomiza as escolha de qual comida comer
  Future<List<MealModel>> _buildDailyMeal(
      List<List<FoodModel>> listOfFood) async {
    List<FoodModel> listOfDrinks = listOfFood[0];
    List<FoodModel> listOfMeat = listOfFood[1];
    List<FoodModel> listOfVegetables = listOfFood[2];
    List<FoodModel> listOfEggs = listOfFood[3];

    var breakfast = MealProviderHelper.buildBreakfast(listOfDrinks);
    var lunch = MealProviderHelper.buildLunch(listOfMeat, listOfVegetables);
    var snack = MealProviderHelper.buildSnack(listOfEggs);
    var dinner = MealProviderHelper.buildDinner(listOfMeat, listOfVegetables);

    return [breakfast, lunch, snack, dinner];
  }

  Future<List<String>> _getFoodsPrefs() async =>
      (await prefs).getStringList(foodPrefsKey);

  saveMealPrefs(String mealType, List<String> list) async {
    //TODO: Implement saveMealPrefs
    (await prefs).setStringList(mealType, list);
  }
}

abstract class MealProviderHelper {
  static Future<List<List<FoodModel>>> getPossibleFoodList(prefs) async {
    List<FoodModel> listOfDrinks = await FoodModelHelper.loadPrefsDrinks(prefs);
    List<FoodModel> listOfMeat = await FoodModelHelper.loadPrefsMeats(prefs);
    List<FoodModel> listOfVegetables =
        await FoodModelHelper.loadPrefsVegetables(prefs);
    List<FoodModel> listOfEggs = await FoodModelHelper.loadEggs();

    return [
      listOfDrinks,
      listOfMeat,
      listOfVegetables,
      listOfEggs,
    ];
  }

  static MealModel buildDinner(
          List<FoodModel> listOfFood, List<FoodModel> listOfExtras) =>
      MealModel(
        mainFoodList: listOfFood.take(3).toList(),
        extraList: listOfExtras,
        extraAmount: 3, //TODO: Decidir a quantidade de extras
        mealType: MealType.dinner,
      );

  static MealModel buildSnack(List<FoodModel> listOfFood) => MealModel(
        mainFoodList: listOfFood.take(3).toList(),
        extraList: [],
        extraAmount: 5, //TODO: Decidir a quantidade de extras
        mealType: MealType.snack,
      );

  static MealModel buildLunch(
          List<FoodModel> listOfFood, List<FoodModel> listOfExtra) =>
      MealModel(
        mainFoodList: listOfFood.take(3).toList(),
        extraList: listOfExtra,
        extraAmount: 3, //TODO: Decidir a quantidade de extras
        mealType: MealType.lunch,
      );

  static MealModel buildBreakfast(List<FoodModel> listOfFood) => MealModel(
        mainFoodList: listOfFood.take(3).toList(),
        extraList: [],
        extraAmount: 0, //TODO: Decidir a quantidade de extras
        mealType: MealType.breakfast,
      );
}
