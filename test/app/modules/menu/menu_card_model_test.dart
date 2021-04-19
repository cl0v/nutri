import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/models/diet_model.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/pages/menu/menu_model.dart';

main() {
  test('toMap', () {
    expect(menu.toMap(), equals(menuJson));
  });

  test('fromMap', () {
    expect(MenuCardModel.fromMap(menuJson), equals(menu));
  });

  
}

MealModel meal = MealModel(
  type: MealType.breakfast,
  img: 'img',
  title: 'title',
);
DietModel diet = DietModel(
  meal: meal,
);
MenuCardModel menu = MenuCardModel(
  diet: diet,
);

var menuJson = {
  "meal": {"type": 0, "img": "img", "title": "title"},
  "mainFoodList": [],
  "extraFoodList": [],
  "selectedFoodIndex": 0,
  "selectedExtrasIndex": []
};
