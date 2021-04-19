import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/models/diet_model.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/pages/menu/menu_model.dart';
import 'package:nutri/app/pages/home/pages/menu/menu_card_viewmodel.dart';
import 'package:nutri/app/providers/food_provider.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';
import 'package:nutri/app/services/shared_local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues(
    {
      'day/${MealType.breakfast.toString()}': jsonEncode(menuJson),
    },
  );

  ILocalStorage storage = SharedLocalStorageService();
  MenuCardViewModel menuCardViewModel = MenuCardViewModel(
    storage: storage,
    diet: PeDietRepository(
      foodProvider: FoodProvider(),
    ),
  );

  test('fetchMenuCardModel', () async {
    var menuModel = await menuCardViewModel.fetchMenuCardModel('day', mealMock);
    expect(menuModel.mainFoodList, equals([]));
  });
  test('fetchMenuCardModel', () async {
    var menuModel = await menuCardViewModel.fetchMenuCardModel('day', mealMock);
    expect(menuModel.meal.title, equals('title'));
  });
  test('fetchMenuCardModel', () async {
    var menuModel = await menuCardViewModel.fetchMenuCardModel('day', mealMock);
    expect(menuModel.meal.type, equals(MealType.breakfast));
  });
}

MealModel mealMock = MealModel(
  type: MealType.breakfast,
  img: 'img',
  title: 'title',
);
DietModel dietMock = DietModel(
  meal: mealMock,
);
MenuCardModel menuMock = MenuCardModel(
  diet: dietMock,
);

var menuJson = {
  "meal": {
    "type": 0,
    "img": "img",
    "title": "title",
  },
  "mainFoodList": [],
  "extraFoodList": [],
  "selectedFoodIndex": 0,
  "selectedExtrasIndex": []
};
