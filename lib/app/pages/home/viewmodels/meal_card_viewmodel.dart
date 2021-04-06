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
    var breakfast = (await diet.breakfast(day)).meal;
    var lunch = (await diet.lunch(day)).meal;
    var snack = (await diet.snack(day)).meal;
    var dinner = (await diet.dinner(day)).meal;
    return [
      MealCardModel.fromMealModel(breakfast),
      MealCardModel.fromMealModel(lunch),
      MealCardModel.fromMealModel(snack),
      MealCardModel.fromMealModel(dinner),
    ];
  }
}
