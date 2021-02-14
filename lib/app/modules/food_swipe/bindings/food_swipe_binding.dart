import 'package:get/get.dart';

import '../controllers/food_swipe_controller.dart';

class FoodSwipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodSwipeController>(
       () => FoodSwipeController(),
    );
  }
}
