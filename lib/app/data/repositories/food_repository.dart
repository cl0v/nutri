import 'package:meta/meta.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/providers/food_provider.dart';

class FoodRepository {
  final FoodProvider provider;

  FoodRepository({@required this.provider});

  Future<List<FoodModel>> loadFoods() => provider.loadFoods();

  Future<List<FoodModel>> sizedFoodList({int amount}) =>
      provider.sizedFoodList(amount);
}
