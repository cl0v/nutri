import 'package:nutri/app/pages/home/models/meal_card_model.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';

abstract class IMealCardVM {
  Future<List<MealCardModel>> fetchMealCardList(String day);
}

class MealCardViewModel implements IMealCardVM {
  final IDiet diet;

  MealCardViewModel({
    required this.diet,
  });

  Future<List<MealCardModel>> fetchMealCardList(day) async {
    return (await diet.fetchDietList(day))
        .map((dietModel) => dietModel.meal)
        .map((meal) => MealCardModel.fromMealModel(meal))
        .toList();
  }
}
