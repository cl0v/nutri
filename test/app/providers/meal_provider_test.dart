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
}
