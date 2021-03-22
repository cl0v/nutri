import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/models/meal_model.dart';

import 'package:nutri/app/data/model/food_model.dart';

class MenuModel {
  //enum
  MealType mealType; //Isso aqui fica melhor como string
  List<FoodModel> mainFoodList;
  List<FoodModel> extraList;
  int extraAmount;
//TODO: Remover, nem estou mais usando (fixei em sempre ter 3 acompanhamentos)
//TODO: Solução basica é contar quantos elementos tem nos extras, se tiver vazia, nao mostra acompanhamentos
//Se tiver 3 ou mais, mostra o selecione
  MenuModel({
    required this.mealType,
    required this.mainFoodList,
    required this.extraList,
    this.extraAmount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'mealType': mealType.index,
      'mainFoodList': mainFoodList.map((x) => x.toMap()).toList(),
      'extraList': extraList.map((x) => x.toMap()).toList(),
      'extraAmount': extraAmount,
    };
  }

  String toJson() => json.encode(toMap());

  factory MenuModel.fromJson(String source) =>
      MenuModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MealModel(mealType: $mealType)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MenuModel &&
        o.mealType == mealType &&
        listEquals(o.mainFoodList, mainFoodList) &&
        listEquals(o.extraList, extraList) &&
        o.extraAmount == extraAmount;
  }

  @override
  int get hashCode {
    return mealType.hashCode ^
        mainFoodList.hashCode ^
        extraList.hashCode ^
        extraAmount.hashCode;
  }

  // factory MealModel.fromMap(Map<String, dynamic>? map) { //TODO: Estudar esse caso
  //   if (map == null) return null;
  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      mealType: MealType.values[map['mealType']],
      mainFoodList: List<FoodModel>.from(
          map['mainFoodList']?.map((x) => FoodModel.fromMap(x))),
      extraList: List<FoodModel>.from(
        map['extraList']?.map(
              //Esse  map['extraList'] é nulo as vezes, mas nao deveria, deveria ser vazio
              (x) => FoodModel.fromMap(x),
            ) ??
            [],
      ),
      extraAmount: map['extraAmount'],
    );
  }
}

const weeklyMealsPrefsKey = 'weeklyMeals';

class MenuProvider {
  //Lembrando que o toJson é uma string, logo o sqflite aceita tambem
  static Future<List<MenuModel>> peDiet() async{
    //TODO: Isso é certamente o food provider
    var mainFoodList = await FoodModelHelper.loadMeats();
    var extraFoodList = await FoodModelHelper.loadVegetables();
    return [
      MenuModel(
        mainFoodList: mainFoodList.take(3).toList(),
        extraList: extraFoodList,
        extraAmount: 5,
        mealType: MealType.breakfast,
      ),
      MenuModel(
        mainFoodList: mainFoodList.take(3).toList(),
        extraList: extraFoodList,
        extraAmount: 5,
        mealType: MealType.lunch,
      ),
      MenuModel(
        mainFoodList: mainFoodList.take(3).toList(),
        extraList: [],
        extraAmount: 0,
        mealType: MealType.snack,
      ),
      MenuModel(
        mainFoodList: mainFoodList.take(3).toList(),
        extraList: [],
        extraAmount: 0,
        mealType: MealType.dinner,
      ),
    ];

    switch (0) {
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
      case 6:
        break;
      case 7:
        break;
      default:
    }
  }

  static List<List<MenuModel>> saveWeeklyMealsOnPrefs(
      ILocalStorage storage, List<List<MenuModel>> listOfDailyMeal) {
    var list = listOfDailyMeal.map((l) => json.encode(l)).toList();
    storage.put(weeklyMealsPrefsKey, list);

    return listOfDailyMeal;
  }

//TODO: Eu acho que estou esquecendo de conferir se o foodswipe (DONE) ja foi e tambem se ja foi buildado as meals da semana
  static Future<List<List<MenuModel>>> getWeeklyMealsFromPrefs(
      ILocalStorage storage) async {
    var foodPrefList = await storage.get(weeklyMealsPrefsKey);
    return foodPrefList.map((String st) {
      List<dynamic> js = json.decode(st);
      return js.map((s) => MenuModel.fromJson(s)).toList();
    }).toList();
  }
}

abstract class MenuProviderHelper {
  static Future<List<String>> _getFoodsPrefsList(storage) async =>
      FoodProvider.getFoodsPrefsList(storage);

  static Future<MenuModel> buildDinner(storage) async {
    var prefs = await _getFoodsPrefsList(storage);
// IDEIA: - Priorizar vegetais de noite
    var mainFoodList =
        await FoodModelHelper.loadDinnerMainFoodsFromPrefs(prefs);
    var extraFoodList = await FoodModelHelper.loadDinnerExtrasFromPrefs(prefs);

    return MenuModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: extraFoodList,
      extraAmount: 3,
      mealType: MealType.dinner,
    );
  }

  static Future<MenuModel> buildSnack(storage) async {
    var prefs = await _getFoodsPrefsList(storage);
    var mainFoodList = await FoodModelHelper.loadSnackMainFoodsFromPrefs(prefs);
    return MenuModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: [],
      extraAmount: 0,
      mealType: MealType.snack,
    );
  }

  static Future<MenuModel> buildLunch(storage) async {
    var prefs = await _getFoodsPrefsList(storage);
    var mainFoodList = await FoodModelHelper.loadLunchMainFoodsFromPrefs(prefs);
    var extraFoodList = await FoodModelHelper.loadLunchExtrasFromPrefs(prefs);
    return MenuModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: extraFoodList,
      extraAmount: 3,
      mealType: MealType.lunch,
    );
  }

  static Future<MenuModel> buildBreakfast(storage) async {
    var prefs = await _getFoodsPrefsList(storage);
    var mainFoodList =
        await FoodModelHelper.loadBreakfastMainFoodsFromPrefs(prefs);
    return MenuModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: [],
      extraAmount: 0,
      mealType: MealType.breakfast,
    );
  }
}
