
import 'package:nutri/app/models/meal_model.dart';

abstract class IMealRepository {
  Future<MealModel> fetchMealByType(MealType type); //TODO: Usar esse
}