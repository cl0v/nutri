import 'package:get/get.dart';
import 'package:nutri/app/data/providers/user_data_provider.dart';
import 'package:nutri/app/data/repositories/user_data_repository.dart';

import 'package:nutri/app/modules/questions/controllers/questions_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionsController>(
      ()  => QuestionsController(
        userDataRepository: UserDataRepository(
          provider: UserDataProvider(
            prefs:  SharedPreferences.getInstance(),
          ),
        ),
      ),
    );
  }
}
