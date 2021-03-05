import 'dart:convert';

import 'package:flutter/services.dart';

//IDEIA: Talvez posso adicionar quanto cada comida vale em pontos, para montar um prato final
// Dar os pontos e calcular quanto cada uma vale para fechar o dia com a pontuaçao necessária
// Exemplo, um frango na pe é 13, + importancia, uns 10, daria 130 pontos
// se fosse 13*1 daria 13 pontos, mas 1 frango nao é suficiente, porém nao tao pouco caso eu queria calcular 100 pontos
//IDEIA: Decidir o que é comida pesada e leve para comer de noite e antes do treino(Normalmente frutas)

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
  String desc;
  //enum
  FoodCategory category;
  //enum
  MainOrExtra mainOrExtra;

  //TODO: Add PE

  FoodModel({
    this.title,
    this.img,
    this.desc,
    this.category,
    this.mainOrExtra,
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
      'category': category?.index,
      'mainOrExtra': mainOrExtra?.index,
    };
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return FoodModel(
      title: map['title'],
      img: map['img'],
      desc: map['desc'],
      category: FoodCategory.values[map['category']],
      mainOrExtra: MainOrExtra.values[map['mainOrExtra']],
    );
  }

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
    var json = await _loadJson();
    var list = json
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

//TODO: Testar se tiver pelo menos uma fruta, deve mostrar o card de frutas
  static Future<List<FoodModel>> _sortJsonByCategoryBasedOnPref(
          List<String> prefs, FoodCategory category) async =>
      (await _sortJsonByCategory(category))
          .where((food) => prefs.contains(food.title))
          .toList();

//TODO: Implement loadFoodsFromPrefs;
  static Future<List<FoodModel>> _loadFoodsFromPreferences(
      List<String> prefs) async {
    if (prefs == null) return [];
    var json = await _loadJson();
    return json
        .where((map) => prefs.contains(map['title']))
        .map((map) => FoodModel.fromMap(map))
        .toList();
  }
}
