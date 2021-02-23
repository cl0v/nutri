import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/providers/meal_provider.dart';
import 'package:nutri/app/data/repositories/meal_repository.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  MealRepository repository = MealRepository(provider: MealProvider());

  test('MealRepository fetchMeals with number of foods', () async {
    var list = await repository.fetchMeals();
    expect(list.length, 3);
  });
  test('Testing fetchMeals', () async {
    var list = await repository.fetchMeals();
    expect(list.length, 3);
  });
}