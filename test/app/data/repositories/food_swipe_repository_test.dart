import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/providers/food_swipe_provider.dart';
import 'package:nutri/app/data/repositories/food_swipe_repository.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  FoodSwipeRepository foodSwipeRepository = FoodSwipeRepository(foodSwipeProvider: FoodSwipeProvider());

  test('Getting one foodSwipeModel from foodSwipeRepository', () async {
    var foodSwipe = await foodSwipeRepository.loadFoodSwipeList();
    expect(foodSwipe.first.category, 'Carnes');
  });
}
