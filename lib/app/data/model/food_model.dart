import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';

const foodPrefsKey = 'foodPrefs';

///Categoria da comida que será servida
enum FoodCategory {
  none,
  drink,
  meat,
  vegetable,
  lowSugarFruits,
  tuber,
  eggs,
  nuts,
  dairy,
  mushroom,
  fruits,
  others,
}

enum MainOrExtra {
  main,
  extra,
  both,
}

class FoodModel {
  String title;
  String img;
  String? desc;
  //enum
  FoodCategory category;
  //enum
  MainOrExtra mainOrExtra;

  //TODO: Add PE

  FoodModel({
    required this.title,
    required this.img,
    this.desc,
    required this.category,
    required this.mainOrExtra,
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is FoodModel && o.title == title && o.img == img && o.desc == desc;
  }

  @override
  int get hashCode => title.hashCode ^ img.hashCode ^ desc.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'img': img,
      'desc': desc,
      'category': category.index,
      'mainOrExtra': mainOrExtra.index,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) => FoodModel(
        title: map['title'],
        img: map['img'],
        desc: map['desc'],
        category: FoodCategory.values[map['category']],
        mainOrExtra: MainOrExtra.values[map['mainOrExtra']],
      );

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'FoodModel(title: $title)';
  }

  static getCategoryFromIndex(int index) => FoodCategory.values[index];
  static getIndexFromCategory(FoodCategory category) => category.index;
}

const jsonPath = 'assets/jsons/food_data.json';

abstract class FoodModelHelper {
  ///Meal builder methods
  static Future<List<FoodModel>> loadLunchMainFoodsFromPrefs(
          List<String> prefs) =>
      _loadMeatsFromPrefs(prefs);

  static Future<List<FoodModel>> loadLunchExtrasFromPrefs(
          List<String> prefs) async =>
      _loadPrefsVegetables(prefs);

  static Future<List<FoodModel>> loadBreakfastMainFoodsFromPrefs(
          List<String> prefs) =>
      _loadDrinksFromPrefs(prefs);

  static Future<List<FoodModel>> loadDinnerMainFoodsFromPrefs(
          List<String> prefs) =>
      _loadMeatsFromPrefs(prefs);

  static Future<List<FoodModel>> loadDinnerExtrasFromPrefs(
          List<String> prefs) =>
      _loadExtrasFromPrefs(prefs);

  static Future<List<FoodModel>> loadSnackMainFoodsFromPrefs(
          List<String> prefs) =>
      _loadEggs();

  ///Food Swipe methods
  ///Recebe todas as carnes cadastradas no banco
  static Future<List<FoodModel>> loadMeats() =>
      _sortJsonByCategory(FoodCategory.meat);

  ///Recebe todas as bebidas cadastradas no banco
  static Future<List<FoodModel>> loadDrinks() =>
      _sortJsonByCategory(FoodCategory.drink);

  ///Recebe todas os vegetais cadastrados no banco
  static Future<List<FoodModel>> loadVegetables() =>
      _sortJsonByCategory(FoodCategory.vegetable);

  ///Recebe todas as frutas cadastradas no banco
  static Future<List<FoodModel>> loadLowSugarFruits() =>
      _sortJsonByCategory(FoodCategory.lowSugarFruits);

  ///Recebe todas os tuberculos cadastrados no banco
  static Future<List<FoodModel>> loadTubers() =>
      _sortJsonByCategory(FoodCategory.tuber);

//Helpers

  static Future<List<FoodModel>> _loadMeatsFromPrefs(List<String> prefs) =>
      _sortJsonByCategoryBasedOnPref(prefs, FoodCategory.meat);

  static Future<List<FoodModel>> _loadDrinksFromPrefs(List<String> prefs) =>
      _sortJsonByCategoryBasedOnPref(prefs, FoodCategory.drink);

  static Future<List<FoodModel>> _loadPrefsVegetables(List<String> prefs) =>
      _sortJsonByCategoryBasedOnPref(prefs, FoodCategory.vegetable);

  static Future<List<FoodModel>> _loadExtrasFromPrefs(
          List<String> prefs) async =>
      _sortByMainOrExtra(
          await _loadFoodsFromPreferences(prefs), MainOrExtra.extra);

  static Future<List<FoodModel>> _loadEggs() async =>
      await _sortJsonByCategory(FoodCategory.eggs);

  static Future<List> _loadJson() async =>
      jsonDecode(await rootBundle.loadString(jsonPath));

  static Future<List<FoodModel>> _sortJsonByCategory(
      FoodCategory category) async {
    var list = (await _loadJson())
        .where((map) =>
            map['category'] == FoodModel.getIndexFromCategory(category))
        .map((map) => FoodModel.fromMap(map))
        .toList();
    list.shuffle();
    return list;
  }

  static List<FoodModel> _sortByMainOrExtra(
          List<FoodModel> list, MainOrExtra mainOrExtra) =>
      list.where((food) => food.mainOrExtra == mainOrExtra).toList();

  static Future<List<FoodModel>> _sortJsonByCategoryBasedOnPref(
          List<String> prefs, FoodCategory category) async =>
      (await _sortJsonByCategory(category))
          .where((food) => prefs.contains(food.title))
          .toList();

  static Future<List<FoodModel>> _loadFoodsFromPreferences(
      List<String> prefs) async {
    var json = await (_loadJson());
    return json
        .where((map) => prefs.contains(map['title']))
        .map((map) => FoodModel.fromMap(map))
        .toList();
  }
}

abstract class FoodProvider {
  static List<String> getFoodsPrefsList(ILocalStorage storage) =>
      storage.get(foodPrefsKey) as List<String>;
}
