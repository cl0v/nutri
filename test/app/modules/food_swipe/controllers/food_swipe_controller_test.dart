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
}

FoodModel f1 = FoodModel(title: "Peito de Frango");
