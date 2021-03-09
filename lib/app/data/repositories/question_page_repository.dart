import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/question_model.dart';
import 'package:nutri/app/data/providers/question_page_provider.dart';

class QuestionPageRepository {
  final QuestionPageProvider provider;

  QuestionPageRepository({@required this.provider});

  Future<List<QuestionModel>> loadQuestionList() => provider.loadQuestionList();

  setQuestionsPrefs(Map<String, String> answers) =>
      provider.setQuestionsPrefs(answers);
}
