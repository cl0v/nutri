import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/data/model/faq_model.dart';

const jsonPath = 'assets/jsons/faq.json';

class FAQProvider {
  FAQProvider();

  Future<List?> _loadJson() async =>
      jsonDecode(await rootBundle.loadString(jsonPath));

  Future<List<FAQModel>> getFaqList() async {
    var json = await (_loadJson() as FutureOr<List<dynamic>>);
    var list = json.map((map) => FAQModel.fromMap(map)).toList();
    return list;
  }
}
