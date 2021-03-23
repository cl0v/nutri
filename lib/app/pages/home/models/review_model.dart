
import 'dart:convert';

import 'package:nutri/app/pages/home/models/overview_model.dart';

class ReviewModel {
  final OverviewModel overviewModel;
  //enum
  final bool done;

  ReviewModel({
    required this.overviewModel,
    required this.done,
  });

  Map<String, dynamic> toMap() {
    return {
      'overviewModel': overviewModel.toMap(),
      'isDone': done,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      overviewModel: OverviewModel.fromMap(map['overviewModel']),
      done: map['isDone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) => ReviewModel.fromMap(json.decode(source));
}
