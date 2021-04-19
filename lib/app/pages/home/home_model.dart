import 'package:nutri/app/models/food_model.dart';
import 'package:nutri/app/models/meal_model.dart';

enum Status {
  None,
  Done,
  Skipped,
}

class HomeModel {
  ///Define a cor do card
  Status status;

  /// Define a refeiçao principal
  MealModel meal;

  /// Define a combinação da dieta (opções de proteina + opcoes de acompanhamento)
  FoodOptionsModel options;

  /// Opções selecionadas na menu page
  SelectedFoodsModel selected;

  HomeModel({
    required this.status,
    required this.meal,
    required this.options,
    required this.selected,
  });
}

class FoodOptionsModel {
  ///Lista de proteinas
  List<FoodModel> meals;
  ///Lista de acompanhamentos
  List<FoodModel> extras;

  FoodOptionsModel({
    required this.meals,
    required this.extras,
  });
}

class SelectedFoodsModel {
  ///Proteina selecionada
  int mealIdx;
  ///Acompanhamentos selecionados
  List<int> extraIdxList;
  SelectedFoodsModel({
    required this.mealIdx,
    required this.extraIdxList,
  });
}
