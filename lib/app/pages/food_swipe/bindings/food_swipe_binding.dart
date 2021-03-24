import 'package:get/get.dart';
import 'package:nutri/app/data/providers/food_swipe_provider.dart';
import 'package:nutri/app/data/repositories/food_swipe_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/food_swipe_controller.dart';

class FoodSwipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodSwipeController>(
      () => FoodSwipeController(
        repository: FoodSwipeRepository(
          provider: FoodSwipeProvider(
            prefs: SharedPreferences.getInstance(),
          ),
        ),
      ),
    );
  }
}
