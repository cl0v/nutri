import 'package:nutri/app/models/diet_model.dart';
import 'package:nutri/app/models/food_model.dart';

class MealCardModel extends DietModel {
  late FoodModel selectedFood; //TODO: Decidir se isso pode ou nao ser nulo
  late List<FoodModel> selectedExtras;

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
