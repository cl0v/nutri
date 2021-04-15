import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/models/food_model.dart';
import 'package:nutri/app/providers/food_provider.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  IFoodProvider foodProvider = FoodProvider();
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
