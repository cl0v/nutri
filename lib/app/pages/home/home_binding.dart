import 'package:get/get.dart';
import 'package:nutri/app/pages/home/home_controller.dart';
import 'package:nutri/app/pages/home/home_viewmodel.dart';
import 'package:nutri/app/repositories/food/assets_food_repository.dart';
import 'package:nutri/app/repositories/meal/firestore_meal_repository.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';
import 'package:nutri/app/services/shared_local_storage_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(
        homeBloc: HomeViewModel(
          storage: SharedLocalStorageService(),
          repository: PeDietRepository(
            foodProvider: AssetsFoodRepository(),
            mealProvider: FirestoreMealRepository(),
          ),
        ),
      ),
    );
  }
}
