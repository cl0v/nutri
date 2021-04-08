import 'package:nutri/app/models/diet_model.dart';
import 'package:nutri/app/models/food_model.dart';

class MealCardModel extends DietModel {
  FoodModel selectedFood;
  List<FoodModel> selectedExtras;

  MealCardModel({
    extraFoodList,
    mainFoodList,
    meal,
    required this.selectedExtras,
    required this.selectedFood,
  }) : super(
          extraFoodList: extraFoodList,
          mainFoodList: mainFoodList,
          meal: meal,
        );
}
