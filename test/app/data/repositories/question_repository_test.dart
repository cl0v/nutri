import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/model/question_model.dart';
import 'package:nutri/app/data/providers/question_provider.dart';
import 'package:nutri/app/data/repositories/question_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Getting questions from JSON and converting to question list', () async {
    QuestionRepository repository = QuestionRepository(
        provider: QuestionProvider(
      prefs: SharedPreferences.getInstance(),
    ));
    var list = await repository.loadQuestionList();
    expect(list.first.question, q1.question);
  });
}
// Map<String, int> foodPrefs = {"cafe": 4};

QuestionModel q1 = QuestionModel(question: "Qual a sua pressão arterial");
