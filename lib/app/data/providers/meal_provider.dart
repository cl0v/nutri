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

  int dailyMealAmount = 4; //4 contando com o cafe da manha
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
    List<FoodModel> listOfMeat = await FoodModelHelper.loadMeats();
    List<FoodModel> listOfDrinks = await FoodModelHelper.loadDrinks();
    List<List<MealModel>> weekMeal = [];
    var dailyMeal = await _buildDailyMeal(listOfDrinks, listOfMeat);

    weekMeal = List.generate(daysInAWeek, (idx) => dailyMeal);
    return weekMeal;
  }

  _buildDailyMeal(listOfDrinks, listOfMeat) async {

    var breakfast = MealModel(
        food: listOfDrinks.first, extras: [], mealType: MealType.breakfast);
    var lunch =
        MealModel(food: listOfMeat[0], extras: [], mealType: MealType.lunch);
    var tea =
        MealModel(food: listOfMeat[1], extras: [], mealType: MealType.tea);
    var dinner =
        MealModel(food: listOfMeat[2], extras: [], mealType: MealType.dinner);

    return [breakfast, lunch, tea, dinner];
  }


}
