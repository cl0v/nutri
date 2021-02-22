import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nutri/app/data/model/question_model.dart';

const jsonPath = 'assets/jsons/questions.json';

//TODO: Trabalhar em cima das questões (Processar informações e tomar decisoes com base nas informações)

class QuestionProvider {
  _loadJson() async {
    return await rootBundle.loadString(jsonPath);
  }

  /// Recebe todas as questions cadastradas no banco de dados
  Future<List<QuestionModel>> loadQuestionList() async {
    var data = await _loadJson();
    List jsonList = jsonDecode(data);
    return jsonList.map((e) => QuestionModel.fromJson(e)).toList();
  }
}
