import 'package:get/get.dart';
import 'package:nutri/app/data/providers/user_preferences_provider.dart';
import 'package:nutri/app/data/repositories/user_preferences_repository.dart';

import 'package:nutri/app/modules/questions/controllers/questions_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionsController>(
      ()  => QuestionsController(
        userDataRepository: UserPreferencesRepository(
          provider: UserPreferencesProvider(
            prefs:  SharedPreferences.getInstance(),
          ),
        ),
      ),
    );
  }
}
