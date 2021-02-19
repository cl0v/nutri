import 'package:nutri/app/data/model/meal_model.dart';

class MealCardModel {
  final MealModel mealModel;
  MealCardState mealCardState;

  MealCardModel({this.mealModel, this.mealCardState});

  @override
  String toString() => 'MealCardModel(mealModel: $mealModel, mealCardState: $mealCardState)';
}

enum MealCardState {
  Skiped,
  None,
  Done,
}
