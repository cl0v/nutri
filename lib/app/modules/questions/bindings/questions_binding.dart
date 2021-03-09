import 'package:get/get.dart';
import 'package:nutri/app/data/providers/question_page_provider.dart';
import 'package:nutri/app/data/repositories/question_page_repository.dart';

import 'package:nutri/app/modules/questions/controllers/questions_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionsController>(
      () => QuestionsController(
        repository: QuestionPageRepository(
          provider: QuestionPageProvider(
            sharedPreferences: SharedPreferences.getInstance(),
          ),
        ),
      ),
    );
  }
}
