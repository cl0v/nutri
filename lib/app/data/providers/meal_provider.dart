import 'dart:math';

import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';

//TODO: Entender com o tempo as escolhar do usuario (padroes etc)
//TODO: Escolher a melhor forma de organizar quais alimentos deverão aparecer;

//TODO: Montar a lista de alimentos no final da semana
//TODO: Dividir 'aleatoriamente' por 7 e cada dia será um meal + 4(por dia)...;
//TODO: Descobrir quantas refeições a pessoa costuma fazer;

class MealProvider {
  Future<List<MealModel>> fetchMeals() async {
    List<MealModel>();
    var foods = await FoodModelHelper.loadAllFoods();
    List meals = List<MealModel>();
    foods.forEach(
      (food) {
        meals.add(
          MealModel(
            food: food,
            meal: MealType.breakfast,
            extras: foods
                .where((f) => f.category == FoodCategory.vegetable)
                .toList(), //TODO: Testar sem a toList
          ),
        );
      },
    );
    _sortMealListByMealOrder(meals);
    return meals.toList();
  }

  _sortMealListByMealOrder(List<MealModel> m1) {
    m1.sort((a, b) => a.meal.index.compareTo(b.meal.index));
    return m1;
  }
}
