import 'package:nutri/app/data/model/extra_model.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/providers/extra_provider.dart';
import 'package:nutri/app/data/providers/food_provider.dart';
import 'package:nutri/app/data/repositories/extra_repository.dart';
import 'package:nutri/app/data/repositories/food_repository.dart';

class MealProvider {
  MealProvider();

  //TODO: Escolher a melhor forma de organizar quais alimentos deverão aparecer;

  FoodRepository _foodRepository = FoodRepository(provider: FoodProvider());
  ExtraRepository _extraRepository = ExtraRepository(provider: ExtraProvider());

//TODO: Separar em um provider helper ou coisa do tipo
  buildMeal(int mealNumber, int foodNumber) {}


//TODO: Estou dando a possibilidade do usuario nao salvar nenhuma comida na foodswipe (Botao de pular)
  _fetchFoods() => _foodRepository.loadFoods();
  _fetchSizedFoodList(amount) => _foodRepository.sizedFoodList(amount: amount);

  _fetchExtras() => _extraRepository.loadExtras();
  _fetchSizedExtraList(amount) => _extraRepository.sizedExtraList(amount: amount);

  Future<List<MealModel>> fetchMeals(int number) async {
    List foods = await _fetchSizedFoodList(number);
    List extras = await _fetchSizedExtraList(number);
    List meals = List<MealModel>();
    foods.forEach(
      (food) => meals.add(
        MealModel(
          food: food,
          extras: extras,
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

final mockedFood = FoodModel(
    title: "Peito de Frango",
    img: "assets/images/foods/peito de frango.jpg",
    desc:
        "Peito de frango é uma alternativa excelente para perder peso e ganhar musculos.");

final mockedExtras = [
  ExtraModel(
    title: "Brócolis",
    img: "assets/images/foods/brócolis.jpg",
    desc: "Brócolis é ótimo para sua saúde.",
  ),
  ExtraModel(
    title: "Alface",
    img: "assets/images/foods/alface.jpg",
    desc:
        "Folhas de alface são as alternativas muito saudáveis para seu prato.",
  ),
];

final mockedExtras2 = [
  ExtraModel(
    title: "Bróloccolis",
    img: "assets/images/foods/brócolis.jpg",
    desc: "Brócolis é ótimo para sua saúde.",
  ),
  ExtraModel(
    title: "Alfaceitao",
    img: "assets/images/foods/alface.jpg",
    desc:
        "Folhas de alface são as alternativas muito saudáveis para seu prato.",
  ),
];
