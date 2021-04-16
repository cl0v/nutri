import 'dart:convert';

import 'package:nutri/app/models/diet_model.dart';

//TODO: Salvar os dados do menuCard para poder voltar e analisar
class MenuCardModel extends DietModel {
  int selectedFoodIndex;
  List<int> selectedExtrasIndex;

  MenuCardModel({
    required DietModel diet,
    this.selectedFoodIndex = 0,
    this.selectedExtrasIndex = const [],
  }) : super(
          meal: diet.meal,
          extraFoodList: diet.extraFoodList,
          mainFoodList: diet.mainFoodList,
        );

  Map<String, dynamic> toMap() => super.toMap()
    ..addAll({
      'selectedFoodIndex': selectedFoodIndex,
      'selectedExtrasIndex': selectedExtrasIndex,
    });

  factory MenuCardModel.fromMap(Map<String, dynamic> map) {
    return MenuCardModel(
      diet: DietModel.fromMap(map),
      selectedFoodIndex: map['selectedFoodIndex'],
      selectedExtrasIndex: List<int>.from(map['selectedExtrasIndex']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuCardModel.fromJson(String source) =>
      MenuCardModel.fromMap(json.decode(source));
}
