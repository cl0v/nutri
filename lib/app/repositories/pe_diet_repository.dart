import 'package:nutri/app/models/diet_model.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/providers/food_provider.dart';
import 'package:nutri/app/providers/meal_provider.dart';

abstract class IDiet {
  List<MealType> availableMeals();
  Future<List<DietModel>> fetchDietList(String day);
  Future<DietModel> fetchDietMeal(String day, MealType mealType);
}

class PeDietRepository extends IDiet { //Pode ser um view model ou repositorio, é o cara responsável por me entregar um modelo DietModel
  final IFoodProvider foodProvider;
  final IMealProvider mealProvider;

  PeDietRepository({
    required this.foodProvider,
    required this.mealProvider,
  });

  @override
  List<MealType> availableMeals() {
    return [
      MealType.breakfast,
      MealType.lunch,
      MealType.snack,
      MealType.dinner,
    ];
  }

  @override
  Future<List<DietModel>> fetchDietList(String day) async {
    return [
      await breakfast(day),
      await lunch(day),
      await snack(day),
      await dinner(day),
    ];
  }

  @override
  Future<DietModel> fetchDietMeal(String day, MealType mealType) async {
    switch (mealType) {
      case MealType.breakfast:
        return breakfast(day);
      case MealType.breakfast:
        return lunch(day);
      case MealType.breakfast:
        return snack(day);
      case MealType.breakfast:
        return dinner(day);
      default:
        return breakfast(day);
    }
  }

  Future<DietModel> breakfast(day) async {
    var meal = await mealProvider.fetchMeal(day, MealType.breakfast);
    var mainFoodList = await foodProvider.loadDrinks();
    return DietModel(
      meal: meal,
      mainFoodList: mainFoodList,
      extraFoodList: [],
    );
  }

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

  Future<DietModel> snack(day) async {
    var meal = await mealProvider.fetchMeal(day, MealType.snack);
    return DietModel(
      meal: meal,
      mainFoodList: [],
      extraFoodList: [],
    );
  }

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
