import 'package:nutri/app/data/model/extras_model.dart';
import 'package:nutri/app/data/model/food_model.dart';

class MealModel {

  //enum
  MealType meal;
  FoodModel food;
  List<ExtraModel> extras;

  //TODO: (123) val.toString().split("").forEach((val) => print(val));

  MealModel({
    this.meal,
    this.food,
    this.extras,
  });

  factory MealModel.fromFoodModel(FoodModel f) {
    return MealModel(
      meal: f.meal.first, //TODO: Decidir quando será a refeiçao
      food: f, 
      extras: [],
    );
  }

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
