import 'package:get/get.dart';
import 'package:nutri/app/pages/home/controllers/home_controller.dart';
import 'package:nutri/app/pages/home/viewmodels/home_state_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/home_title_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/menu_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/overview_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/review_viewmodel.dart';
import 'package:nutri/app/repositories/pe_diet/default_pe_diet_repository.dart';
import 'package:nutri/app/services/shared_local_storage_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(
        titleViewModel: HomeTitleViewModel(),
        overviewViewModel: OverviewViewModel(
          repository: DefaultPeDietRepository(
            storage: SharedLocalStorageService()
          ),
        ),
        menuViewModel: MenuViewModel(
          storage: SharedLocalStorageService(),
          repository: DefaultPeDietRepository(
            storage: SharedLocalStorageService()
          ),
        ),
        reviewViewModel: ReviewViewModel(
          repository: DefaultPeDietRepository(
            storage: SharedLocalStorageService()
          ),
        ),
        homeStateViewModel: HomeStateViewModel(
          storage: SharedLocalStorageService()
        ),
        // repository: HomeRepository(
        //   provider: HomeProvider(
        //     storage: SharedLocalStorageService(),
        //   ),
        // ),
      ),
    );
  }
}
