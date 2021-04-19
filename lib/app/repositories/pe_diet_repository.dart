import 'package:nutri/app/models/diet_model.dart';
import 'package:nutri/app/models/food_model.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/providers/food_provider.dart';
import 'package:nutri/app/providers/meal_provider.dart';

abstract class IDiet {
  Future<DietModel> fetchDietFromMeal(MealModel meal);
  Future<List<DietModel>> fetchMealList();
}

class PeDietRepository extends IDiet {
  //Pode ser um view model ou repositorio, é o cara responsável por me entregar um modelo DietModel
  final IFoodProvider foodProvider;
  final IMealProvider mealProvider;

  PeDietRepository({
    required this.foodProvider,
    required this.mealProvider,
  });

  @override
  Future<DietModel> fetchDietFromMeal(MealModel meal) {
    switch (meal.type) {
      case MealType.breakfast:
        return breakfast(meal);
      case MealType.lunch:
        return lunch(meal);
      case MealType.snack:
        return snack(meal);
      case MealType.dinner:
        return dinner(meal);
    }
  }

  Future<DietModel> breakfast(meal) async {
    var mainFoodList = await foodProvider.loadFoodList(FoodCategory.drink);
    return DietModel(
      meal: meal,
      mainFoodList: mainFoodList,
      extraFoodList: [],
    );
  }

  Future<DietModel> lunch(meal) async {
    var mainFoodList = await foodProvider.loadFoodList(FoodCategory.meat);
    var extraFoodList = await foodProvider.loadFoodList(FoodCategory.vegetable);
    return DietModel(
      meal: meal,
      mainFoodList: mainFoodList,
      extraFoodList: extraFoodList.take(6).toList(),
    );
  }

  Future<DietModel> snack(meal) async {
    return DietModel(
      meal: meal,
      mainFoodList: [],
      extraFoodList: [],
    );
  }

  Future<DietModel> dinner(meal) async {
    var mainFoodList = await foodProvider.loadFoodList(FoodCategory.meat);
    var extraFoodList = await foodProvider.loadFoodList(FoodCategory.vegetable);
    return DietModel(
      meal: meal,
      mainFoodList: mainFoodList,
      extraFoodList: extraFoodList.take(6).toList(),
    );
  }

  @override
  Future<List<DietModel>> fetchMealList() async {
    List<DietModel> list = [];
    for (var type in MealType.values) {
      MealModel meal = await mealProvider.fetchMealByType(type);
      list.add(await fetchDietFromMeal(meal));
    }
    return list;
  }
}
