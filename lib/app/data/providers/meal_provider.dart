import 'package:nutri/app/data/model/extra_model.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';

class MealProvider {
  MealProvider();

  Future<List<MealModel>> loadMeals() async {
    await Future.delayed(Duration(seconds: 0));
    return [
      MealModel(
        extras: mockedExtras,
        food: mockedFood,
        meal: MealType.lunch,
      ),
      MealModel(
        extras: mockedExtras2,
        food: mockedFood,
        meal: MealType.breakfast,
      ),
      MealModel(
        extras: mockedExtras,
        food: mockedFood,
        meal: MealType.dinner,
      ),
    ];
    //TODO: Implement
  }

//TODO: Atualmente todas as responsabilidades da home deveriam estar aqui

}

final mockedFood = FoodModel(
    title: "Peito de Frango",
    img: "assets/images/foods/peito de frango.jpg",
    prefs: "peito de frango",
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
