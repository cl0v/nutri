import 'package:nutri/app/interfaces/pages/home/viewmodels/meal_card_viewmodel_interface.dart';
import 'package:nutri/app/interfaces/providers/diet_interface.dart';
import 'package:nutri/app/pages/home/models/meal_card_model.dart';

class MealCardViewModel implements IMealCardVM {
  final IDiet diet;

  MealCardViewModel({
    required this.diet,
  });

  Future<List<MealCardModel>> fetchMealCardList(int day) async {
    var breakfast = (await diet.getBreakfast(day)).meal;
    var lunch = (await diet.getLunch(day)).meal;
    var snack = (await diet.getSnack(day)).meal;
    var dinner = (await diet.getDinner(day)).meal;
    return [
      MealCardModel(
        img: breakfast.img,
        day: breakfast.day,
        type: breakfast.type,
      ),
      MealCardModel(
        img: lunch.img,
        day: lunch.day,
        type: lunch.type,
      ),
      MealCardModel(
        img: snack.img,
        day: snack.day,
        type: snack.type,
      ),
      MealCardModel(
        img: dinner.img,
        day: dinner.day,
        type: dinner.type,
      ),
    ];
  }
}
