import 'package:nutri/app/models/diet_model.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/providers/food_provider.dart';
import 'package:nutri/app/providers/meal_provider.dart';

abstract class IDiet {
  Future<DietModel> breakfast(String day);
  Future<DietModel> lunch(String day);
  Future<DietModel> snack(String day);
  Future<DietModel> dinner(String day);
}

class PeDietRepository extends IDiet {
  final IFoodProvider foodProvider;
  final IMealProvider mealProvider;

  PeDietRepository({
    required this.foodProvider,
    required this.mealProvider,
  });

  @override
  Future<DietModel> breakfast(day) async {
    var meal = await mealProvider.fetchMeal(day, MealType.breakfast);
    var mainFoodList = await foodProvider.loadDrinks();
    return DietModel(
      meal: meal,
      mainFoodList: mainFoodList,
      extraFoodList: [],
    );
  }

  @override
  Future<DietModel> lunch(day) async {
    var meal = await mealProvider.fetchMeal(day, MealType.lunch);
    var mainFoodList = await foodProvider.loadMeats();
    var extraFoodList = await foodProvider.loadVegetables();
    return DietModel(
      meal: meal,
      mainFoodList: mainFoodList,
      extraFoodList: extraFoodList.take(6).toList(),
    );
  }

  @override
  Future<DietModel> snack(day) async {
    var meal = await mealProvider.fetchMeal(day, MealType.snack);
    // var mainFoodList = await FoodModelHelper().loadMeats();
    return DietModel(
      meal: meal,
      mainFoodList: [],
      extraFoodList: [],
    );
  }

  @override
  Future<DietModel> dinner(day) async {
    var meal = await mealProvider.fetchMeal(day, MealType.dinner);
    var mainFoodList = await foodProvider.loadMeats();
    var extraFoodList = await foodProvider.loadVegetables();
    return DietModel(
      meal: meal,
      mainFoodList: mainFoodList,
      extraFoodList: extraFoodList.take(6).toList(),
    );
  }
}
