import 'package:nutri/app/models/diet_model.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/providers/food_provider.dart';
import 'package:nutri/app/providers/meal_provider.dart';

abstract class IDiet {
  Future<DietModel> getBreakfast(String day);
  Future<DietModel> getLunch(String day);
  Future<DietModel> getSnack(String day);
  Future<DietModel> getDinner(String day);
}

class PeDietRepository extends IDiet {
  final IFoodProvider foodProvider;
  final IMealProvider mealProvider;

  PeDietRepository({
    required this.foodProvider,
    required this.mealProvider,
  });

  @override
  Future<DietModel> getBreakfast(day) async {
    var meal = await mealProvider.fetchMeal(day, MealType.breakfast);
    var mainFoodList = await foodProvider.loadDrinks();
    return DietModel(
      meal: meal,
      mainFoodList: mainFoodList,
      extraFoodList: [],
    );
  }

  @override
  Future<DietModel> getLunch(day) async {
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
  Future<DietModel> getSnack(day) async {
    var meal = await mealProvider.fetchMeal(day, MealType.snack);
    // var mainFoodList = await FoodModelHelper().loadMeats();
    return DietModel(
      meal: meal,
      mainFoodList: [],
      extraFoodList: [],
    );
  }

  @override
  Future<DietModel> getDinner(day) async {
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
