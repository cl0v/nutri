import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/providers/food_provider.dart';
import 'package:nutri/app/data/repositories/food_repository.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  FoodRepository repository = FoodRepository(provider: FoodProvider());
  test('Getting all foods from JSON and converting to food list', () async {
    var list = await repository.loadAllFoods();
    expect(list.first.title, f1.title);
  });

  test('Getting meats from food data json', () async {
    var list = await repository.loadMeats();
    expect(list.first.category, FoodCategory.meat);
  });

  test('Getting fruits from food data json', () async {
    var list = await repository.loadFruits();
    expect(list.first.category, FoodCategory.fruit);
  });

  test('Getting vegetables from food data json', () async {
    var list = await repository.loadVegetables();
    expect(list.first.category, FoodCategory.vegetable);
  });

  test('Getting drinks from food data json', () async {
    var list = await repository.loadDrinks();
    expect(list.first.category, FoodCategory.drink);
  });

  test('Getting foodList from mockedFoodPreferences', () async {
    var mockedPrefsList = ["Peito de Frango", "Ovos"]; // Future...
    var foodList = await repository.loadFoodsFromPreferences(mockedPrefsList);
    var expected = foodList.map((food) => food.title).toList();
    expect(expected, mockedPrefsList);
  });

  test('Getting lenght of foodList from mockedFoodPreferences', () async {
    var mockedPrefsList = ["Peito de Frango", "Salmão"]; // Future...
    var foodList = await repository.loadFoodsFromPreferences(mockedPrefsList);
    var expected = foodList.map((food) => food.title).toList();
    expect(expected.length, mockedPrefsList.length);
  });

  test('Getting one food from foodList cause misspelling one title', () async {
    var mockedPrefsList = ["Peito de Frango", "Salmo"]; // Future...
    var foodList = await repository.loadFoodsFromPreferences(mockedPrefsList);
    var expected = foodList.map((food) => food.title).toList();
    expect(expected, ["Peito de Frango"]);
  });

  test('Getting empty foodList, after null mockedPrefsList', () async {
    var mockedPrefsList;
    var foodList = await repository.loadFoodsFromPreferences(mockedPrefsList);
    var expected = foodList.map((food) => food.title).toList();
    expect(expected, []);
  });
}

FoodModel f1 = FoodModel(
  title: "Peito de Frango",
);
