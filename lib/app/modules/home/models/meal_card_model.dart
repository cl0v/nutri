import 'dart:convert';

import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';

class MealCardModel {
  final MealModel mealModel;
  //enum
  late MealCardState mealCardState;
  FoodModel? selectedFood;
  List<FoodModel> selectedExtras;

  MealCardModel({
    required this.mealModel,
    this.mealCardState = MealCardState.None,
    this.selectedFood,
    this.selectedExtras = const [],
  });

  Map<String, dynamic> toMap() => {
        'mealModel': mealModel.toMap(),
        'mealCardState': mealCardState.index,
        'selectedFood': selectedFood!.toMap(),
        'selectedExtras': selectedExtras.map((e) => e.toMap()).toList(),
      };

  factory MealCardModel.fromMap(Map<String, dynamic> map) => MealCardModel(
        mealModel: MealModel.fromMap(map['mealModel']),
        mealCardState: MealCardState.values[map['mealCardState']],
        selectedFood: FoodModel.fromMap(map['selectedFood']),
        selectedExtras: List<FoodModel>.from(
          map['extraList']?.map(
                //Esse  map['extraList'] é nulo as vezes, mas nao deveria, deveria ser vazio
                (x) => FoodModel.fromMap(x),
              ) ??
              [],
        ),
      );

  String toJson() => json.encode(toMap());

  factory MealCardModel.fromJson(String source) =>
      MealCardModel.fromMap(json.decode(source));
}

enum MealCardState {
  Skiped,
  None,
  Done,
}
