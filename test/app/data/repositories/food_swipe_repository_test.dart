import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/providers/food_swipe_provider.dart';
import 'package:nutri/app/data/repositories/food_swipe_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  FoodSwipeRepository foodSwipeRepository = FoodSwipeRepository(
    provider: FoodSwipeProvider(
      prefs: SharedPreferences.getInstance(),
    ),
  );

  group('filterBasedOnExerciceIntensity', () {
    var filter;
    test('', () {
      // Exercice intensity = 0
      // IDEIA: Fruit amount to be choosen should be 7, 1 for each day...
      
      filter = foodSwipeRepository.filterBasedOnExerciceIntensity();
      print(filter);
    });
  });
}
