import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/question_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionPageProvider {
  final Future<SharedPreferences> sharedPreferences;

  QuestionPageProvider({required this.sharedPreferences});

  Future<List<QuestionModel>> loadQuestionList() async => QuestionProvider.loadQuestionList();

  void setQuestionsPrefs(Map<String, String> answers) => answers
      .forEach((key, value) async => (await sharedPreferences).setString(key, value));
}
