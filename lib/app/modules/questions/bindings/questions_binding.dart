import 'package:get/get.dart';
import 'package:nutri/app/data/providers/question_provider.dart';
import 'package:nutri/app/data/repositories/question_repository.dart';

import 'package:nutri/app/modules/questions/controllers/questions_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionsController>(
      () => QuestionsController(
        repository: QuestionRepository(
          provider: QuestionProvider(
            prefs: SharedPreferences.getInstance(),
          ),
        ),
      ),
    );
  }
}
