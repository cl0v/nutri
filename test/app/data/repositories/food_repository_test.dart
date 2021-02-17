import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/food_rating_card_model.dart';
import 'package:nutri/app/data/providers/food_provider.dart';
import 'package:nutri/app/data/repositories/food_repository.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  FoodRepository repository = FoodRepository(provider: FoodProvider());
  test('Getting foods from JSON and converting to food list', () async {
    var list = await repository.loadFoodList();
    expect(list.first.title, f1.title);
  });

  test('Testing FoodRatingCardModel', () async {
    var list = await repository.loadAvailableFoods();
    expect(list.first.prefs, fr1.prefs);
  });
}

FoodRatingCardModel fr1 = FoodRatingCardModel(
  title: "Peito de Frango",
  prefs: "frango",
);
/*
"title": "Peito de Frango",
    "img": "assets/images/foods/peito_de_frango_grelhado.jpg",
    "prefs": "frango",
*/
Map<String, int> foodPrefs = {"cafe": 4};

FoodModel f1 = FoodModel(title: "Peito de Frango");
