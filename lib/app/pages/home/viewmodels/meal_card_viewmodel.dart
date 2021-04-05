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
    var breakfast = (await diet.getBreakfast(day)).meal;
    var lunch = (await diet.getLunch(day)).meal;
    var snack = (await diet.getSnack(day)).meal;
    var dinner = (await diet.getDinner(day)).meal;
    return [
      MealCardModel(
        img: breakfast.img,
        type: breakfast.type,
      ),
      MealCardModel(
        img: lunch.img,
        type: lunch.type,
      ),
      MealCardModel(
        img: snack.img,
        type: snack.type,
      ),
      MealCardModel(
        img: dinner.img,
        type: dinner.type,
      ),
    ];
  }
}
