import 'package:get/get.dart';
import 'package:nutri/app/pages/home/controllers/home_controller.dart';
import 'package:nutri/app/pages/home/viewmodels/home_state_viewmodel.dart';
import 'package:nutri/app/providers/pe_diet/default_pe_diet_provider.dart';
import 'package:nutri/app/services/shared_local_storage_service.dart';
import 'package:nutri/app/pages/home/viewmodels/home_diet_viewmodel.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(
        homeDietViewModel: HomeDietViewModel(
          diet: DefaultPeDietProvider(),
          storage: SharedLocalStorageService(),
        ),
        storage: SharedLocalStorageService(),
        homeStateViewModel: HomeStateViewModel(
          storage: SharedLocalStorageService(),
        ),
      ),
    );
  }
}
