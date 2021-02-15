import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/modules/food_swipe/controllers/food_swipe_controller.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Getting foods from JSON and converting to food list', () async {
    FoodSwipeController controller = FoodSwipeController();
    var list = await controller.loadFoodList();
    expect(list.first.title, f1.title);
  });
  test('Creating map of prefs foods onRatingTapped', () async {
    FoodSwipeController controller = FoodSwipeController();
    var list = await controller.loadFoodList();
    var cafe = list[list.indexWhere((element) => element.prefs == "cafe")];
    controller.onRatingTapped(cafe, 4.0);
    var prefs = controller.foodPrefs;
    expect(
      prefs, foodPrefs
    );
  });
}

Map<String, int> foodPrefs = {"cafe": 4};

FoodModel f1 = FoodModel(title: "Peito de Frango");
