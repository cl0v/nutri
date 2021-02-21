import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/model/extra_model.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/providers/meal_provider.dart';
import 'package:nutri/app/data/repositories/meal_repository.dart';

//TODO: Casos possiveis:
//TODO: Tres refeiçoes, duas variaçoes de comida
//TODO: Duas Refeiçoes, uma variaçao de comida
//TODO: Tres refeiçoes, tres variaçoes comida
//TODO: Duas Refeiçoes, duas variaçoes de comida
//....
main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  MealRepository repository = MealRepository(provider: MealProvider());

  test('MealRepository fetchMeals with number of foods', () async {
    var list = await repository.fetchMeals(3);
    expect(list.length, 3);
  });
  test('Testing fetchMeals', () async {
    var list = await repository.fetchMeals(3);
    expect(list.length, 3);
  });
}

var mockedMealList = [
  MealModel(
    extras: mockedExtras2,
    food: mockedFood,
    meal: MealType.breakfast,
  ),
  MealModel(
    extras: mockedExtras,
    food: mockedFood,
    meal: MealType.lunch,
  ),
  MealModel(
    extras: mockedExtras,
    food: mockedFood,
    meal: MealType.dinner,
  ),
];

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
