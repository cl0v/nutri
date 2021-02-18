import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/data/model/question_model.dart';

const jsonPath = 'assets/jsons/questions.json';

class QuestionProvider {
  QuestionProvider();

  _loadJson() async {
    return await rootBundle.loadString(jsonPath);
  }
  
  Future<List<QuestionModel>> loadQuestionList() async {
    var data = await _loadJson();
    List jsonList = jsonDecode(data);
    return jsonList.map((e) => QuestionModel.fromJson(e)).toList();
  }
}
