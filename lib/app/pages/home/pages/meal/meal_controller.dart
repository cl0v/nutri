import 'package:get/get.dart';
import 'package:nutri/app/pages/home/pages/meal/interfaces/meal_controller_interface.dart';

import 'meal_card_model.dart';
class MealController extends GetxController implements IMealController {

  @override
  void onInit() {
    mealCardModel = Get.arguments['meal'];
    super.onInit();
  }

  @override
  late MealCardModel mealCardModel;

  @override
  void onDonePressed() {
    // TODO: implement onDonePressed
  }

  @override
  void onExtraFoodTapped(int idx) {
    // TODO: implement onExtraFoodTapped
  }

  @override
  void onMainFoodTapped(int idx) {
    // TODO: implement onMainFoodTapped
  }

  @override
  void onSkipPressed() {
    // TODO: implement onSkipPressed
  }

  
}
