
import 'dart:convert';

import 'package:flutter/services.dart';

class QuestionModel {
  String question;
  String prefs;
  List<String> options;

  QuestionModel({this.question, this.prefs, this.options});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    prefs = json['prefs'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['prefs'] = this.prefs;
    data['options'] = this.options;
    return data;
  }
}
const jsonPath = 'assets/jsons/questions.json';

abstract class QuestionProvider{

  static _loadJson() async {
    return await rootBundle.loadString(jsonPath);
  }

  static Future<List<QuestionModel>> loadQuestionList() async {
    var data = await _loadJson();
    List jsonList = json.decode(data);
    return jsonList.map((e) => QuestionModel.fromJson(e)).toList();
  }

  
}