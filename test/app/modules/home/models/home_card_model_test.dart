import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/models/diet_model.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/home_card_model.dart';

main() {
  test('To map', () {
    HomeCardModel homeCardModel = HomeCardModel(
      diet: DietModel(
          meal: MealModel.fromMap(meal), extraFoodList: [], mainFoodList: []),
      status: HomeCardStatus.None,
    );
    expect(homeCardModel.toMap(), json);
  });

  test('From map', () {
    HomeCardModel homeCardModel = HomeCardModel.fromMap(json);
    expect(homeCardModel.status, HomeCardStatus.None);
  });
}

var json = {
  "diet": {
    "meal": {
      "type": 0,
      "img": "assets/images/meals/10.png",
      "title": "Café",
    },
    "mainFoodList": [],
    "extraFoodList": []
  },
  "status": 0
};

var meal = {
  "img": "assets/images/meals/10.png",
  "type": 0,
  "title": "Café",
};
