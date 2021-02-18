
import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/providers/meal_provider.dart';

class MealRepository {
  final MealProvider provider;

  MealRepository({@required this.provider});

  Future<List<MealModel>> loadMeals() =>
      provider.loadMeals();
}