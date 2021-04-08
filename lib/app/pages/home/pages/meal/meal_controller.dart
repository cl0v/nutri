import 'package:get/get.dart';

import 'meal_card_model.dart';
class MealController extends GetxController {
  late MealCardModel mealPageModel;

  @override
  void onInit() {
    mealPageModel = Get.arguments['meal'];
    super.onInit();
  }

  
}
