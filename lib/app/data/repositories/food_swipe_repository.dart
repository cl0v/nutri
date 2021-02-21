import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/food_swipe_model.dart';
import 'package:nutri/app/data/providers/food_swipe_provider.dart';

class FoodSwipeRepository {
  FoodSwipeProvider foodSwipeProvider;

  FoodSwipeRepository({@required this.foodSwipeProvider});

  Future<List<FoodSwipeModel>> loadFoodSwipeList() =>
      foodSwipeProvider.loadFoodSwipeList();
}
