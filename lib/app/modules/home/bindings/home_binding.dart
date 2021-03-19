import 'package:get/get.dart';
import 'package:nutri/app/modules/home/providers/home_provider.dart';
import 'package:nutri/app/modules/home/repositories/home_repository.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(
        repository: HomeRepository(
          provider: HomeProvider(
            sharedPreferences: SharedPreferences.getInstance(),
          ),
        ),
      ),
    );
  }
}
