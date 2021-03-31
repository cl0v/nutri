import 'package:nutri/app/pages/home/models/meal_card_model.dart';

abstract class IMealCardVM {
  Future<List<MealCardModel>> fetchMealCardList(int day);
}
