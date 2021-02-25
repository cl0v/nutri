import 'dart:convert';

import 'package:flutter/services.dart';

//TODO: Criar model que definde o cardapio do dia( o model final, mais importante para o home) ???
//FIXME: Pensar em como remover o tomate do cardapio de refeiçao de frutas
//FIXME: Pensar onde encaixar ovos
//FIXME: Decidir o que é comida pesada e leve para comer de noite e antes do treino
///Categoria da comida que será servida
enum FoodCategory {
  none,
  drink,
  meat,
  vegetable,
  fruit,
  nuts,
  dairy,
  tuber,
  mushroom,
  others,
}

///Qualquer coisa que possa ser prato principal receberá categoria MainExtraCategory.main
///Qualquer coisa que possa ser acompanhamento receberá categoria MainExtraCategory.extra
///Qualquer coisa que não se enquadra em nenhuma categoria receberá categoria MainExtraCategory.none
enum MainOrExtra {
  none,
  main,
  extra,
  both,
}



//FIXME: Corrigir tomate pois nao permitirei frutas no almoço(Provavelmente tomate tambem nao)
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

  factory FoodModel.fromJson(String source) =>
      FoodModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FoodModel(title: $title, img: $img, desc: $desc, category: $category)';
  }

  static getCategoryFromIndex(int index) => FoodCategory.values[index];
  static getIndexFromCategory(FoodCategory category) => category.index;
}

const jsonPath = 'assets/jsons/food_data.json';

abstract class FoodModelHelper {
  /// Recebe todas as comidas cadastradas no banco
  static Future<List<FoodModel>> loadAllFoods() async {
    var json = await _loadJson();
    return json.map((map) => FoodModel.fromMap(map)).toList();
  }

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
  static Future<List<FoodModel>> loadFruits() =>
      _sortJsonByCategory(FoodCategory.fruit);

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

//TODO: Implement loadFoodsFromPrefs;
  static Future<List<FoodModel>> loadFoodsFromPreferences(
      List<String> prefs) async {
    if (prefs == null) return [];
    var json = await _loadJson();
    return json
        .where((map) => prefs.contains(map['title']))
        .map((map) => FoodModel.fromMap(map))
        .toList();
  }
}
