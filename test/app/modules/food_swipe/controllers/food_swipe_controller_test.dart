import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/providers/food_provider.dart';
import 'package:nutri/app/data/repositories/food_repository.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Getting foods from JSON and converting to food list', () async {
    FoodRepository repository = FoodRepository(provider: FoodProvider());
    var list = await repository.loadFoodList();
    expect(list.first.title, f1.title);
  });
  test('Creating map of prefs foods onRatingTapped', () async {
    FoodRepository repository = FoodRepository(
      provider: FoodProvider()
    );
    var list = await repository.loadFoodList();
    var cafe = list[list.indexWhere((element) => element.prefs == "cafe")];
    // controller.onRatingTapped(cafe, 4.0);
    // var prefs = controller.foodPrefs;
    // expect(
    //   prefs, foodPrefs
    // );
  }, skip: true);
}

Map<String, int> foodPrefs = {"cafe": 4};

FoodModel f1 = FoodModel(title: "Peito de Frango");
