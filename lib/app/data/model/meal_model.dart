import 'package:nutri/app/data/model/extras_model.dart';
import 'package:nutri/app/data/model/food_model.dart';

class MealModel {
  Meal meal; //Pode ser enum
  FoodModel food;
  List<ExtraModel> extras;
  //TODO: Lista de acompanhamentos

  MealModel({
    this.meal,
    this.food,
    this.extras,
  });

  factory MealModel.fromFoodModel(FoodModel f) {
    return MealModel(
      meal: setMeal(f.meal.first),
      food: f, //TODO: Corrigir isso aq
      extras: [],
    );
  }

  static setMeal(String m) {
    switch (m) {
      case "breakfast":
        return Meal.breakfast;
      case "brunch":
        return Meal.brunch;
      case "elevenses":
        return Meal.elevenses;
      case "lunch":
        return Meal.lunch;
      case "tea":
        return Meal.tea;
      case "supper":
        return Meal.supper;
      case "dinner":
        return Meal.dinner;
      default:
        return null;
    }
  }

  static getTranslatedMeal(Meal m) {
    switch (m) {
      case Meal.breakfast:
        return "Café da manhã";
      case Meal.brunch:
        return "brunch";
      case Meal.elevenses:
        return "elevenses";
      case Meal.lunch:
        return "Almoço";
      case Meal.tea:
        return "Café da tarde";
      case Meal.supper:
        return "Jantar";
      case Meal.dinner:
        return "Jantar";

      default:
        return null;
    }
  }

  // static List<String> mealList = [
  //   "breakfast",
  //   "brunch",
  //   "elevenses",
  //   "lunch",
  //   "tea",
  //   "supper",
  //   "dinner",
  // ];

  @override
  String toString() => 'MealModel(meal: $meal)';
}

enum Meal {
  breakfast,
  brunch,
  elevenses,
  lunch,
  tea,
  supper,
  dinner,
}
