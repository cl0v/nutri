
import 'dart:convert';

import 'package:nutri/app/pages/home/models/meal_model.dart';

class ReviewModel {
  final OverviewModel overviewModel;
  //enum
  final bool isDone;

  ReviewModel({
    required this.overviewModel,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'overviewModel': overviewModel.toMap(),
      'isDone': isDone,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      overviewModel: OverviewModel.fromMap(map['overviewModel']),
      isDone: map['isDone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) => ReviewModel.fromMap(json.decode(source));
}
