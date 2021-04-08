import 'package:nutri/app/pages/home/models/home_meal_model.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';

abstract class IMealCardVM {
  Future<List<HomeMealModel>> fetchMealCardList(String day);
}

class MealCardViewModel implements IMealCardVM {
  final IDiet diet;

  MealCardViewModel({
    required this.diet,
  });

  Future<List<HomeMealModel>> fetchMealCardList(day) async {
    return (await diet.fetchDietList(day))
        .map((dietModel) => dietModel.meal)
        .map((meal) => HomeMealModel.fromMealModel(meal))
        .toList();
  }
}
