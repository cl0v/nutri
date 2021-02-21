import 'package:flutter_test/flutter_test.dart';
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