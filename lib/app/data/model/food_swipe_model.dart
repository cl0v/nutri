import 'package:nutri/app/data/model/food_model.dart';

class FoodSwipeModel {
  String category;
  int amount;
  List<FoodModel> foods;

  FoodSwipeModel({
    this.category,
    this.amount,
    this.foods,
  });

  //...Data???....

  static String getCategory(FoodCategory category) {
    switch (category) {
      case FoodCategory.meat:
        return 'Carnes';
      case FoodCategory.drink:
        return 'Bebidas';
      case FoodCategory.vegetable:
        return 'Vegetais';
      case FoodCategory.fruit:
        return 'Frutas';
      default:
        return '';
    }
  }

  @override
  String toString() =>
      'FoodSwipeModel(category: $category, amount: $amount, foods: $foods)';
}
