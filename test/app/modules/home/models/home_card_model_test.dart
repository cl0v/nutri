import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/home_card_model.dart';

main() {
  test('To map', () {
    MealCardModel homeCardModel = MealCardModel(
      meal: MealModel.fromMap(meal),
      status: HomeCardStatus.None,
    );
    expect(homeCardModel.toMap(), json);
  });

  test('From map', () {
    MealCardModel homeCardModel = MealCardModel.fromMap(json);
    expect(homeCardModel.status, HomeCardStatus.None);
  });
}

var json = {
  "meal": {
    "type": 0,
    "img": "assets/images/meals/10.png",
    "title": "Café",
  },
  "status": 0
};

var meal = {
  "img": "assets/images/meals/10.png",
  "type": 0,
  "title": "Café",
};
