import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/providers/food_provider.dart';

  //TODO: Entender com o tempo as escolhar do usuario (padroes etc)
  //TODO: Escolher a melhor forma de organizar quais alimentos deverão aparecer;

class MealProvider {

  FoodProvider _foodProvider = FoodProvider();

  Future<List<MealModel>> fetchMeals(int number) async {
    List<MealModel>();
    var foods = (await _foodProvider.loadAllFoods()).take(number).toList();
    List meals = List<MealModel>();
    foods.forEach(
      (food) => meals.add(
        MealModel(
          food: food,
          meal: MealType.breakfast,
        ),
      ),
    ); //entender como faz interable
    _sortMealListByMealOrder(meals);
    return meals;
  }

  _sortMealListByMealOrder(List<MealModel> m1) {
    m1.sort((a, b) => a.meal.index.compareTo(b.meal.index));
    return m1;
  }
}
