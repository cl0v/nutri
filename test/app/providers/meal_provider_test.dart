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

  test('First meal of the day should be breakfast', () async {
    var meal = await mealProvider.fetchMeal('01/04/2021', MealType.breakfast);
    expect(meal.type, equals(MealType.breakfast));
  });
  test('Second meal of the day should be lunch', () async {
    var meal = await mealProvider.fetchMeal('01/04/2021', MealType.lunch);
    expect(meal.type, equals(MealType.lunch));
  });
  test('Thrid meal of the day should be snack', () async {
    var meal = await mealProvider.fetchMeal('01/04/2021', MealType.snack);
    expect(meal.type, equals(MealType.snack));
  });
  test('Last meal of the day should be dinner', () async {
    var meal = await mealProvider.fetchMeal('01/04/2021', MealType.dinner);
    expect(meal.type, equals(MealType.dinner));
  });

  test('The meal should stay saved on prefs after requested', () async {
    var expected = await mealProvider.fetchMeal('01/04/2021', MealType.dinner);
    var matcher = await mealProvider.fetchMeal('01/04/2021', MealType.dinner);
    expect(expected, equals(matcher));
  });
}
