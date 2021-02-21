import 'package:get/get.dart';
import 'package:nutri/app/data/providers/food_provider.dart';
import 'package:nutri/app/data/providers/food_preferences_provider.dart';
import 'package:nutri/app/data/repositories/food_repository.dart';
import 'package:nutri/app/data/repositories/food_preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/food_swipe_controller.dart';

class FoodSwipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodSwipeController>(
      () => FoodSwipeController(
        foodPreferencesRepository: FoodPreferencesRepository(
          provider: FoodPreferencesProvider(
            sharedPreferences: SharedPreferences.getInstance(),
          ),
        ),
      ),
    );
  }
}
