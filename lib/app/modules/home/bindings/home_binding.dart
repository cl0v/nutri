import 'package:get/get.dart';
import 'package:nutri/app/data/providers/food_provider.dart';
import 'package:nutri/app/data/repositories/food_repository.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        foodRepository: FoodRepository(
          provider: FoodProvider(),
        ),
      ),
    );
  }
}
