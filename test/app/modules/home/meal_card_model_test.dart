import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/meal_card_model.dart';

main() {
  test('To map', () {
    MealCardModel homeCardModel = MealCardModel(
      meal: MealModel.fromMap(meal),
      status: MealCardStatus.None,
    );
    expect(homeCardModel.toMap(), json);
  });

  test('From map', () {
    MealCardModel homeCardModel = MealCardModel.fromMap(json);
    expect(homeCardModel.status, MealCardStatus.None);
  });
}

var json = {
  "type": 0,
  "img": "assets/images/meals/10.png",
  "title": "Café",
  "status": 0
};

var meal = {
  "img": "assets/images/meals/10.png",
  "type": 0,
  "title": "Café",
};
