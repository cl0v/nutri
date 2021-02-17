import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/food_rating_card_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/providers/food_provider.dart';
import 'package:nutri/app/data/repositories/food_repository.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  FoodRepository repository = FoodRepository(provider: FoodProvider());
  test('Getting foods from JSON and converting to food list', () async {
    var list = await repository.loadFoodList();
    expect(list.first.title, f1.title);
  });

  test('FoodRatingCardModel', () async {
    var list = await repository.loadAvailableFoods();
    expect(list.first.prefs, fr1.prefs);
  });

  test('MealModel.fromFoodModel constructor', () async {
    var list = await repository.loadMeals();
    expect(list.first.meal, m1.meal);
  });
}

FoodRatingCardModel fr1 = FoodRatingCardModel(
  title: "Peito de Frango",
  prefs: "frango",
);

FoodModel f1 = FoodModel(
  title: "Peito de Frango",
  meal: ["lunch"],
);

MealModel m1 = MealModel(
  // food: f1,
  // extras: [],
  meal: MealModel.setMeal(f1.meal.first),
);

// oodModel f1 = FoodModel(title: "Peito de Frango");

/*
"title": "Peito de Frango",
    "img": "assets/images/foods/peito_de_frango_grelhado.jpg",
    "prefs": "frango",
*/
Map<String, int> foodPrefs = {"cafe": 4};
