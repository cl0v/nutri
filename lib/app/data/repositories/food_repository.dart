import 'package:meta/meta.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/food_rating_card_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/providers/food_provider.dart';

class FoodRepository {
  final FoodProvider provider;

  FoodRepository({@required this.provider});

  Future<List<FoodModel>> loadFoodList() => provider.loadFoodList();

  Future<List<FoodRatingCardModel>> loadAvailableFoods() =>
      provider.loadAvailableFoods();

  Future<List<MealModel>> loadMeals() => provider.loadMeals();

}
