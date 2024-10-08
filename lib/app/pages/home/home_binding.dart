import 'package:get/get.dart';
import 'package:nutri/app/pages/home/home_controller.dart';
import 'package:nutri/app/pages/home/meal_card_viewmodel.dart';
import 'package:nutri/app/providers/food_provider.dart';
import 'package:nutri/app/providers/meal_provider.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';
import 'package:nutri/app/services/shared_local_storage_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(
        mealCardViewModel: MealCardViewModel(
          storage: SharedLocalStorageService(),
          mealProvider: MealProvider(
            storage: SharedLocalStorageService(),
          ),
        ),
      ),
    );
  }
}
