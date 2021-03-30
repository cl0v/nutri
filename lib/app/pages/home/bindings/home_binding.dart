import 'package:get/get.dart';
import 'package:nutri/app/pages/home/controllers/home_controller.dart';
import 'package:nutri/app/pages/home/controllers/home_title_controller.dart';
import 'package:nutri/app/pages/home/viewmodels/home_title_viewmodel.dart';
import 'package:nutri/app/providers/pe_diet/default_pe_diet_provider.dart';
import 'package:nutri/app/services/shared_local_storage_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(
        diet: DefaultPeDietProvider(),
        storage: SharedLocalStorageService(),
      ),
    );
  }
}
