import 'package:get/get.dart';
import 'package:nutri/app/pages/home/providers/home_provider.dart';
import 'package:nutri/app/pages/home/repositories/home_repository.dart';
import 'package:nutri/app/pages/home/controllers/home_controller.dart';
import 'package:nutri/app/services/shared_local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(
        repository: HomeRepository(
          provider: HomeProvider(
            storage: SharedLocalStorageService(),
          ),
        ),
      ),
    );
  }
}
