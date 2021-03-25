import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';
import 'package:nutri/app/interfaces/repositories/pe_diet_interface.dart';

class CarnivorePeDietRepository implements IPeDiet{
  final ILocalStorage storage;
  CarnivorePeDietRepository({required this.storage});

  @override
  Future<List<MealModel>> getOverviewList(int day) async {
    var json =
        await jsonDecode(await rootBundle.loadString('assets/jsons/meal.json'))
            as List;

    return json
        .map((map) => MealModel.fromMap(map))
        .where((meal) => meal.day == 1)
        .toList();
  }

  @override
  Future<List<MenuModel>> getMenuList() {
    // TODO: implement getMenuList
    throw UnimplementedError();
  }

  @override
  Future<List<ReviewModel>> getReviewList() {
    // TODO: implement getReviewList
    throw UnimplementedError();
  }

  @override
  Future setReview(MealModel overviewModel, bool done) {
    // TODO: implement setReview
    throw UnimplementedError();
  }

}
