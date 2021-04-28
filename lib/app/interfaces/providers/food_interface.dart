
import 'package:nutri/app/models/food_model.dart';

abstract class IFoodRepository {
  Future<List<FoodModel>> loadFoodList(FoodCategory category);
}
