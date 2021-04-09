import 'dart:convert';

import 'package:nutri/app/models/diet_model.dart';

enum HomeCardStatus {
  None,
  Skipped,
  Done,
}

class HomeCardModel extends DietModel {
  //enum
  HomeCardStatus status;

  HomeCardModel({
    required DietModel diet,
    required this.status,
  }) : super(meal: diet.meal);

  factory HomeCardModel.fromDietModel(DietModel dietModel) {
    return HomeCardModel(diet: dietModel, status: HomeCardStatus.None);
  }

  factory HomeCardModel.fromMap(Map<String, dynamic> map) {
    return HomeCardModel(
      diet: DietModel.fromMap(map['diet']),
      status: HomeCardStatus.values[map['status']],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {'diet': super.toMap(), 'status': status.index};
  }

  factory HomeCardModel.fromJson(String source) =>
      HomeCardModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

}
