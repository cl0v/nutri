import 'package:meta/meta.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/providers/food_provider.dart';

class FoodRepository {
  final FoodProvider provider;

  FoodRepository({@required this.provider});

  Future<List<FoodModel>> loadAllFoods() => provider.loadAllFoods();
  Future<List<FoodModel>> loadMeats() => provider.loadMeats();
  Future<List<FoodModel>> loadDrinks() => provider.loadDrinks();
  Future<List<FoodModel>> loadFruits() => provider.loadFruits();
  Future<List<FoodModel>> loadVegetables() => provider.loadVegetables();

  Future<List<FoodModel>> loadFoodsFromPreferences(List<String> list) =>
      provider.loadFoodsFromPreferences(list); 
}
