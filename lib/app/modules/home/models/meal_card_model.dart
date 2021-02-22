import 'package:nutri/app/data/model/meal_model.dart';

class MealCardModel {
  final MealModel mealModel;
  MealCardState mealCardState;
  List<int> extrasSelectedIndex;

  MealCardModel({
    this.mealModel,
    this.mealCardState = MealCardState.None,
    this.extrasSelectedIndex = const <int>[], //TODO: Soluçao parcial foi remover a constante
  });

  @override
  String toString() =>
      'MealCardModel(mealModel: $mealModel, mealCardState: $mealCardState)';
}

enum MealCardState {
  Skiped,
  None,
  Done,
}
