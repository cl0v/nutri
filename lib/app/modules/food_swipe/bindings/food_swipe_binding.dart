import 'package:get/get.dart';
import 'package:nutri/app/data/providers/user_preferences_provider.dart';
import 'package:nutri/app/data/repositories/user_preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/food_swipe_controller.dart';

class FoodSwipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodSwipeController>(
      () => FoodSwipeController(
          userPreferencesRepository: UserPreferencesRepository(
        provider: UserPreferencesProvider(
          sharedPreferences: SharedPreferences.getInstance(),
        ),
      )),
    );
  }
}
