import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/models/food_model.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';
import 'package:nutri/app/interfaces/repositories/pe_diet_interface.dart';

class DefaultPeDietRepository implements IPeDiet {
 final ILocalStorage storage;

  DefaultPeDietRepository({required this.storage});

  final _reviewKey = 'reviewListKey';
  String get reviewKey =>
      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day.toString()}/$_reviewKey';

  @override
  Future<List<MenuModel>> getMenuList() async {
    //TODO: Corrigir a forma que recebo o menu
    var mainFoodList = await FoodModelHelper.loadMeats();
    var drinkFoodList = await FoodModelHelper.loadDrinks();
    // var snackFoodList = await FoodModelHelper.load
    var extraFoodList = await FoodModelHelper.loadVegetables();
    var dinnerExtrasFoodList = await FoodModelHelper.loadTubers();
    var overviewList = await getOverviewList(DateTime.now().weekday);
    return [
      
      MenuModel(
            overview: overviewList[0],
            mainFoodList: drinkFoodList.take(3).toList(),
            extraFoodList: [],
          ),
      MenuModel(
            overview: overviewList[1],
            mainFoodList: mainFoodList.take(3).toList(),
            extraFoodList: extraFoodList.take(9).toList(),
          ),
      MenuModel(
            overview: overviewList[2],
            mainFoodList: [],
            extraFoodList: [],
          ),
      MenuModel(
            overview: overviewList[3],
            mainFoodList: mainFoodList.take(3).toList(),
            extraFoodList: dinnerExtrasFoodList.take(9).toList(),
          ),
    ];
   
  }

  @override
  Future<List<MealModel>> getOverviewList(int day) async {
    var json =
        await jsonDecode(await rootBundle.loadString('assets/jsons/meal.json'))
            as List;

    return json
        .map((map) => MealModel.fromMap(map))
        .where((meal) => meal.day == day)
        .toList();
  }

  @override
  Future<List<ReviewModel>> getReviewList() async {
    List<dynamic> json = await storage.get(reviewKey) ?? [];
    return json.map((e) => ReviewModel.fromJson(e)).toList();
  }

  @override
  Future setReview(MealModel overviewModel, bool done) async {
    List<ReviewModel> reviewList = await getReviewList();
    ReviewModel reviewModel =
        ReviewModel(overviewModel: overviewModel, done: done);
    reviewList.add(reviewModel);
    List<String> list = [];
    list.addAll(reviewList.map((e) => e.toJson()));

    storage.put(reviewKey, list);
  }
}
