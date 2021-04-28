import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/interfaces/providers/food_interface.dart';
import 'package:nutri/app/models/food_model.dart';
import 'package:nutri/app/repositories/food/assets_food_repository.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  IFoodRepository foodProvider = AssetsFoodRepository();
  test('Food Provider drinks', () async {
    var list = await foodProvider.loadFoodList(FoodCategory.drink);
    list.forEach((element) {
      expect(element.category, equals(FoodCategory.drink));
    });
  });
  test('Food Provider veggies', () async {
    var list = await foodProvider.loadFoodList(FoodCategory.vegetable);
    list.forEach((element) {
      expect(element.category, equals(FoodCategory.vegetable));
    });
  });
  test('Food Provider meat', () async {
    var list = await foodProvider.loadFoodList(FoodCategory.meat);
    list.forEach((element) {
      expect(element.category, equals(FoodCategory.meat));
    });
  });
 
}
