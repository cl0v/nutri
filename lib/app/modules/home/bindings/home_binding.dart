import 'package:get/get.dart';
import 'package:nutri/app/data/providers/home_provider.dart';
import 'package:nutri/app/data/repositories/home_provider.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        repository: HomeRepository(
          provider: HomeProvider(
            sharedPreferences: SharedPreferences.getInstance(),
          ),
        ),
      ),
    );
  }
}
