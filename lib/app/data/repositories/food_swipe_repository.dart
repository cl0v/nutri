import 'package:nutri/app/data/model/food_swipe_model.dart';
import 'package:nutri/app/data/providers/food_swipe_provider.dart';

class FoodSwipeRepository {
  FoodSwipeProvider provider;

  FoodSwipeRepository({required this.provider});

  Future<List<FoodSwipeModel>> loadFoodSwipeList() =>
      provider.loadFoodSwipeList();

  Future setFoodPreferences(List<String> list) async => await provider.setFoodsPrefs(list);
}
