import 'package:nutri/app/data/model/extra_model.dart';
import 'package:nutri/app/data/model/food_model.dart';

class MealModel {

  //enum
  MealType meal;
  FoodModel food;
  List<ExtraModel> extras;

  MealModel({
    this.meal,
    this.food,
    this.extras,
  });


  static getTranslatedMeal(MealType m) {
    switch (m) {
      case MealType.breakfast:
        return "Café da manhã";
      case MealType.brunch:
        return "brunch";
      case MealType.elevenses:
        return "elevenses";
      case MealType.lunch:
        return "Almoço";
      case MealType.tea:
        return "Café da tarde";
      case MealType.supper:
        return "Jantar";
      case MealType.dinner:
        return "Jantar";

      default:
        return null;
    }
  }

}
