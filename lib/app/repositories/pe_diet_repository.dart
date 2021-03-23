import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/interfaces/repositories/diet_interface.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';
import 'package:nutri/app/pages/home/models/overview_model.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';

class PeDietRepository implements IDiet {

  final ILocalStorage storage;

  PeDietRepository({required this.storage});

  final _reviewKey = 'reviewListKey';
  String get reviewKey => '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day.toString()}/$_reviewKey';

  @override
  Future<List<MenuModel>> getMenuList() async {
    var mainFoodList = await FoodModelHelper.loadMeats();
    var extraFoodList = await FoodModelHelper.loadVegetables();
    var overviewList = await getOverviewList(DateTime.now().weekday);
    return overviewList
        .map(
          (e) => MenuModel(
            overview: e,
            mainFoodList: mainFoodList.take(3).toList(),
            extraList: extraFoodList,
          ),
        )
        .toList();
  }

  @override
  Future<List<OverviewModel>> getOverviewList(int day) async {
    var json =
        await jsonDecode(await rootBundle.loadString('assets/jsons/meal.json'))
            as List;

    return json
        .map((map) => OverviewModel.fromMap(map))
        .where((meal) => meal.day == day)
        .toList();
  }

  @override
  Future<List<ReviewModel>> getReviewList() async {
    List<dynamic> json = await storage.get(reviewKey) ?? [];
    return json.map((e) => ReviewModel.fromJson(e)).toList();
  }

  @override
  Future setReview(OverviewModel overviewModel, bool done) async {
    List<ReviewModel> reviewList = await getReviewList();
    ReviewModel reviewModel =
        ReviewModel(overviewModel: overviewModel, done: done);
    reviewList.add(reviewModel);
    List<String> list = [];
    list.addAll(reviewList.map((e) => e.toJson()));

    storage.put(reviewKey, list);
  }
}
