import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return {
      'status': status.index,
      'meal': meal.toMap(),
      'options': options.toMap(),
      'selected': selected.toMap(),
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      status: Status.values[map['status']],
      meal: MealModel.fromMap(map['meal']),
      options: FoodOptionsModel.fromMap(map['options']),
      selected: SelectedFoodsModel.fromMap(map['selected']),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) => HomeModel.fromMap(json.decode(source));
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

  Map<String, dynamic> toMap() {
    return {
      'meals': meals.map((x) => x.toMap()).toList(),
      'extras': extras.map((x) => x.toMap()).toList(),
    };
  }

  factory FoodOptionsModel.fromMap(Map<String, dynamic> map) {
    return FoodOptionsModel(
      meals: List<FoodModel>.from(map['meals']?.map((x) => FoodModel.fromMap(x))),
      extras: List<FoodModel>.from(map['extras']?.map((x) => FoodModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodOptionsModel.fromJson(String source) => FoodOptionsModel.fromMap(json.decode(source));
}

class SelectedFoodsModel {
  ///Proteina selecionada
  int mealIdx;
  ///Acompanhamentos selecionados
  List<int> extraIdxList;
  SelectedFoodsModel({
     this.mealIdx = 0,
     this.extraIdxList = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'mealIdx': mealIdx,
      'extraIdxList': extraIdxList,
    };
  }

  factory SelectedFoodsModel.fromMap(Map<String, dynamic> map) {
    return SelectedFoodsModel(
      mealIdx: map['mealIdx'],
      extraIdxList: List<int>.from(map['extraIdxList']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SelectedFoodsModel.fromJson(String source) => SelectedFoodsModel.fromMap(json.decode(source));
}
