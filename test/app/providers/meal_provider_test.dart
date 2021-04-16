import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/providers/meal_provider.dart';
import 'package:nutri/app/services/shared_local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  IMealProvider mealProvider = MealProvider(
    storage: SharedLocalStorageService(),
  );

  var day = '01/04/2021';

  group('Fetch meal by category | ', () {
    test('should be breakfast', () async {
      var meal = await mealProvider.fetchMeal(day, MealType.breakfast);
      expect(meal.type, equals(MealType.breakfast));
    });
    test('should be lunch', () async {
      var meal = await mealProvider.fetchMeal(day, MealType.lunch);
      expect(meal.type, equals(MealType.lunch));
    });
    test('should be snack', () async {
      var meal = await mealProvider.fetchMeal(day, MealType.snack);
      expect(meal.type, equals(MealType.snack));
    });
    test('should be dinner', () async {
      var meal = await mealProvider.fetchMeal(day, MealType.dinner);
      expect(meal.type, equals(MealType.dinner));
    });
  });

  group('MealBuilder', () {
    test('The meal should stay saved on prefs after requested', () async {
      var expected = await mealProvider.fetchMeal(day, MealType.dinner);
      var matcher = await mealProvider.fetchMeal(day, MealType.dinner);
      expect(expected, equals(matcher));
    });


  });
}
