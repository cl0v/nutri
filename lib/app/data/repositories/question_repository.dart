import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/question_model.dart';
import 'package:nutri/app/data/providers/question_provider.dart';

class QuestionRepository {
  final QuestionProvider provider;

  QuestionRepository({@required this.provider});

  Future<List<QuestionModel>> loadQuestionList() => provider.loadQuestionList();
}
