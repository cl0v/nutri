import 'package:get/get.dart';
import 'package:nutri/app/pages/home/home_controller.dart';
import 'package:nutri/app/pages/home/viewmodels/home_card_viewmodel.dart';
import 'package:nutri/app/providers/food_provider.dart';
import 'package:nutri/app/providers/meal_provider.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';
import 'package:nutri/app/services/shared_local_storage_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(
        homeCardViewModel: HomeCardViewModel(),
        diet: PeDietRepository( //TODO: Diet nao precisa de storage nem fudendoooo
         //é o home card view model que vai ver se ja tem algo salvo no storage, se nao tiver, builda pela pe diet
          foodProvider: FoodProvider(),
          mealProvider: MealProvider(
            storage: SharedLocalStorageService(),
          ),
        ),
        storage: SharedLocalStorageService(),
      ),
    );
  }
}
