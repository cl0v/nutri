import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/models/meal_model.dart';

main() {
  test('Meal from json', () {
    var meal = MealModel.fromMap(map);
    expect(meal.meal, equals(MealType.dinner));
  });
}

const map = {"img": "assets/images/meals/33.png", "meal": 3, "day": 3};
