import 'package:nutri/app/models/diet_model.dart';
import 'package:nutri/app/models/food_model.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/meal_card_model.dart';

class MenuModel extends MealCardModel {
  final List<FoodModel> mainFoodList;
  final List<FoodModel> extraFoodList;

  MenuModel({
    required MealModel meal,
    required this.mainFoodList,
    required this.extraFoodList,
  }) : super(
          type: meal.type,
          img: meal.img,
          title: meal.title
        );

  factory MenuModel.fromDietModel(DietModel diet) {
    return MenuModel(
      meal: diet.meal,
      mainFoodList: diet.mainFoodList,
      extraFoodList: diet.extraFoodList,
    );
  }
}
