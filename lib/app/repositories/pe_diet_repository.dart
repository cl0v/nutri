import 'package:nutri/app/models/diet_model.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/providers/food_provider.dart';

abstract class IDiet {
  // List<MealType> availableMeals();
  // Future<List<DietModel>> fetchDietList(String ;
  Future<DietModel> fetchDiet(MealModel meal);
  // Future<DietModel> fetchDietMeal(String  MealType mealType);
}

class PeDietRepository extends IDiet {
  //Pode ser um view model ou repositorio, é o cara responsável por me entregar um modelo DietModel
  final IFoodProvider foodProvider;

  PeDietRepository({
    required this.foodProvider,
  });


  @override
  Future<DietModel> fetchDiet(MealModel meal) {
    switch (meal.type) {
      case MealType.breakfast:
        return breakfast(meal);
      case MealType.lunch:
        return lunch(meal);
      case MealType.snack:
        return snack(meal);
      case MealType.dinner:
        return dinner(meal);
      default:
        return breakfast(meal);
    }
  }

  Future<DietModel> breakfast(meal) async {
    var mainFoodList = await foodProvider.loadDrinks();
    return DietModel(
      meal: meal,
      mainFoodList: mainFoodList,
      extraFoodList: [],
    );
  }

  Future<DietModel> lunch( meal) async {
    var mainFoodList = await foodProvider.loadMeats();
    var extraFoodList = await foodProvider.loadVegetables();
    return DietModel(
      meal: meal,
      mainFoodList: mainFoodList,
      extraFoodList: extraFoodList.take(6).toList(),
    );
  }

  Future<DietModel> snack( meal) async {
    return DietModel(
      meal: meal,
      mainFoodList: [],
      extraFoodList: [],
    );
  }

  Future<DietModel> dinner( meal) async {
    var mainFoodList = await foodProvider.loadMeats();
    var extraFoodList = await foodProvider.loadVegetables();
    return DietModel(
      meal: meal,
      mainFoodList: mainFoodList,
      extraFoodList: extraFoodList.take(6).toList(),
    );
  }

}
