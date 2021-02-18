import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/providers/food_provider.dart';
import 'package:nutri/app/data/repositories/food_repository.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  FoodRepository repository = FoodRepository(provider: FoodProvider());
  test('Getting all foods from JSON and converting to food list', () async {
    var list = await repository.loadFoods();
    expect(list.first.title, f1.title);
  });
}


FoodModel f1 = FoodModel(
  title: "Peito de Frango",
);

