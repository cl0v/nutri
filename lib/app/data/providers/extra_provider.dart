import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/data/model/extra_model.dart';

const jsonPath = 'assets/jsons/extra_data.json';

class ExtraProvider {
  ExtraProvider();

  Future<List> _loadJson() async =>
      jsonDecode(await rootBundle.loadString(jsonPath));


  Future<List<ExtraModel>> loadExtras() async {
    var json = await _loadJson();
    return json.map((e) => ExtraModel.fromJson(e)).toList();
  }

  Future<List<ExtraModel>> sizedExtraList(int amount) async =>
      (await loadExtras()).take(amount).toList();
}

// var extras = <ExtraCardModel>[
//   ExtraCardModel(food: fList[1], amount: 2, unidade: UnidadeType.unidade),
//   ExtraCardModel(food: fList[0], amount: 1, unidade: UnidadeType.xicara),
//   ExtraCardModel(food: fList[2], amount: 3, unidade: UnidadeType.porcao),
//   ExtraCardModel(food: fList[1], amount: 2, unidade: UnidadeType.unidade),
//   ExtraCardModel(food: fList[0], amount: 1, unidade: UnidadeType.xicara),
//   ExtraCardModel(food: fList[2], amount: 3, unidade: UnidadeType.porcao),
//   ExtraCardModel(food: fList[1], amount: 2, unidade: UnidadeType.unidade),
//   ExtraCardModel(food: fList[0], amount: 1, unidade: UnidadeType.xicara),
//   ExtraCardModel(food: fList[2], amount: 3, unidade: UnidadeType.porcao),
// ];
