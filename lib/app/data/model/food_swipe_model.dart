import 'package:nutri/app/data/model/food_model.dart';

class FoodSwipeModel {
  String category;
  int maximum;
  int minimum;
  List<FoodModel> foods;

  FoodSwipeModel({
    this.category,
    this.maximum,
    this.minimum,
    this.foods,
  });

  static String getCategory(FoodCategory category) {
    switch (category) {
      case FoodCategory.meat:
        return 'Carnes';
      case FoodCategory.drink:
        return 'Bebidas';
      case FoodCategory.vegetable:
        return 'Vegetais';
      case FoodCategory.tuber:
        return 'Legumes';
      case FoodCategory.lowSugarFruits:
        return 'Frutas sem açucar';
      case FoodCategory.others:
        return 'Outros';
      default:
        return '';
    }
  }

}
