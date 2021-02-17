import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/data/model/extra_model.dart';

const jsonPath = 'assets/jsons/extra_data.json';

class ExtraProvider {
  ExtraProvider();

  _loadJson() async {
    return await rootBundle.loadString(jsonPath);
  }

  Future<List<ExtraModel>> loadExtras() async {
    var data = await _loadJson();
    List jsonList = jsonDecode(data);
    return jsonList.map((e) => ExtraModel.fromJson(e)).toList();
  }

  sortedExtras() {
    
  }
}
