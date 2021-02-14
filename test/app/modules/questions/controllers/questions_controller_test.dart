import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/model/question_model.dart';
import 'package:nutri/app/modules/questions/controllers/questions_controller.dart';

main() {
  test('Getting questions from JSON and converting to question list', () async {
    QuestionsController controller = QuestionsController();
    var list = await controller.loadQuestionList();
    expect(list.first.question, q1.question);
  });
}

QuestionModel q1 = QuestionModel(question: "De onde vem a sua comida");

//  "question": "De onde vem a sua comida",
