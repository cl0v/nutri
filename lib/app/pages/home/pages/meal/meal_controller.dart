import 'package:get/get.dart';

import 'meal_card_model.dart';

abstract class IMealController {
  late MealCardModel mealCardModel;
  void onMainFoodTapped(int idx);
  void onExtraFoodTapped(int idx); //TODO: Ajustar para ja receber a lista
  void onDonePressed();
  void onSkipPressed();
}

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
