import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/providers/meal_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  IMealProvider mealProvider = MealProvider(
  );

  group('Fetch meal by category | ', () {
    test('should be breakfast', () async {
      var meal = await mealProvider.fetchMealByType(MealType.breakfast);
      expect(meal.type, equals(MealType.breakfast));
    });
    test('should be lunch', () async {
      var meal = await mealProvider.fetchMealByType( MealType.lunch);
      expect(meal.type, equals(MealType.lunch));
    });
    test('should be snack', () async {
      var meal = await mealProvider.fetchMealByType( MealType.snack);
      expect(meal.type, equals(MealType.snack));
    });
    test('should be dinner', () async {
      var meal = await mealProvider.fetchMealByType( MealType.dinner);
      expect(meal.type, equals(MealType.dinner));
    });
  });
}
