import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:nutri/app/data/model/question_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const jsonPath = 'assets/jsons/questions.json';

//TODO: Trabalhar em cima das questões (Processar informações e tomar decisoes com base nas informações)

class QuestionProvider {
  final Future<SharedPreferences> prefs;

  QuestionProvider({@required this.prefs});

  _loadJson() async {
    return await rootBundle.loadString(jsonPath);
  }

  /// Recebe todas as questions cadastradas no banco de dados
  Future<List<QuestionModel>> loadQuestionList() async {
    var data = await _loadJson();
    List jsonList = jsonDecode(data);
    return jsonList.map((e) => QuestionModel.fromJson(e)).toList();
  }

//FIXME: Nao preciso receber as questions na questionPage, AINDA
  Future<Map<String, String>> getQuestionsPrefs() async {
    Map<String, String> map = Map();
    var p = await prefs;
    p.getKeys().toList().where((key) => key.contains('q_')).forEach((key) {
      map[key] = p.getString(key);
    });
    return map;
  }

  void setQuestionsPrefs(Map<String, String> answers) => answers
      .forEach((key, value) async => (await prefs).setString(key, value));
}
