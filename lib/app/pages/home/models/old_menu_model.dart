import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/models/overview_model.dart';

import 'package:nutri/app/data/model/food_model.dart';

class OldMenuModel {
  //TODO: Remover OldMenu e passar para Menu
  //enum
  MealType mealType; //Isso aqui fica melhor como string
  List<FoodModel> mainFoodList;
  List<FoodModel> extraList;
  int extraAmount;
//TODO: Remover, nem estou mais usando (fixei em sempre ter 3 acompanhamentos)
//TODO: Solução basica é contar quantos elementos tem nos extras, se tiver vazia, nao mostra acompanhamentos
//Se tiver 3 ou mais, mostra o selecione
  OldMenuModel({
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

  factory OldMenuModel.fromJson(String source) =>
      OldMenuModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MealModel(mealType: $mealType)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is OldMenuModel &&
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
  factory OldMenuModel.fromMap(Map<String, dynamic> map) {
    return OldMenuModel(
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
  static Future<List<OldMenuModel>> peDiet() async{
    //TODO: Isso é certamente o food provider
    var mainFoodList = await FoodModelHelper.loadMeats();
    var extraFoodList = await FoodModelHelper.loadVegetables();
    return [
      OldMenuModel(
        mainFoodList: mainFoodList.take(3).toList(),
        extraList: extraFoodList,
        extraAmount: 5,
        mealType: MealType.breakfast,
      ),
      OldMenuModel(
        mainFoodList: mainFoodList.take(3).toList(),
        extraList: extraFoodList,
        extraAmount: 5,
        mealType: MealType.lunch,
      ),
      OldMenuModel(
        mainFoodList: mainFoodList.take(3).toList(),
        extraList: [],
        extraAmount: 0,
        mealType: MealType.snack,
      ),
      OldMenuModel(
        mainFoodList: mainFoodList.take(3).toList(),
        extraList: [],
        extraAmount: 0,
        mealType: MealType.dinner,
      ),
    ];
  }

  static List<List<OldMenuModel>> saveWeeklyMealsOnPrefs(
      ILocalStorage storage, List<List<OldMenuModel>> listOfDailyMeal) {
    var list = listOfDailyMeal.map((l) => json.encode(l)).toList();
    storage.put(weeklyMealsPrefsKey, list);

    return listOfDailyMeal;
  }

//TODO: Eu acho que estou esquecendo de conferir se o foodswipe (DONE) ja foi e tambem se ja foi buildado as meals da semana
  static Future<List<List<OldMenuModel>>> getWeeklyMealsFromPrefs(
      ILocalStorage storage) async {
    var foodPrefList = await storage.get(weeklyMealsPrefsKey);
    return foodPrefList.map((String st) {
      List<dynamic> js = json.decode(st);
      return js.map((s) => OldMenuModel.fromJson(s)).toList();
    }).toList();
  }
}

abstract class MenuProviderHelper {
  static Future<List<String>> _getFoodsPrefsList(storage) async =>
      FoodProvider.getFoodsPrefsList(storage);

  static Future<OldMenuModel> buildDinner(storage) async {
    var prefs = await _getFoodsPrefsList(storage);
// IDEIA: - Priorizar vegetais de noite
    var mainFoodList =
        await FoodModelHelper.loadDinnerMainFoodsFromPrefs(prefs);
    var extraFoodList = await FoodModelHelper.loadDinnerExtrasFromPrefs(prefs);

    return OldMenuModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: extraFoodList,
      extraAmount: 3,
      mealType: MealType.dinner,
    );
  }

  static Future<OldMenuModel> buildSnack(storage) async {
    var prefs = await _getFoodsPrefsList(storage);
    var mainFoodList = await FoodModelHelper.loadSnackMainFoodsFromPrefs(prefs);
    return OldMenuModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: [],
      extraAmount: 0,
      mealType: MealType.snack,
    );
  }

  static Future<OldMenuModel> buildLunch(storage) async {
    var prefs = await _getFoodsPrefsList(storage);
    var mainFoodList = await FoodModelHelper.loadLunchMainFoodsFromPrefs(prefs);
    var extraFoodList = await FoodModelHelper.loadLunchExtrasFromPrefs(prefs);
    return OldMenuModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: extraFoodList,
      extraAmount: 3,
      mealType: MealType.lunch,
    );
  }

  static Future<OldMenuModel> buildBreakfast(storage) async {
    var prefs = await _getFoodsPrefsList(storage);
    var mainFoodList =
        await FoodModelHelper.loadBreakfastMainFoodsFromPrefs(prefs);
    return OldMenuModel(
      mainFoodList: mainFoodList.take(3).toList(),
      extraList: [],
      extraAmount: 0,
      mealType: MealType.breakfast,
    );
  }
}
