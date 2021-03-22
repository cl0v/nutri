import 'package:get/get.dart';
import 'package:nutri/app/pages/home/providers/home_provider.dart';
import 'package:nutri/app/pages/home/repositories/home_repository.dart';
import 'package:nutri/app/pages/home/controllers/home_controller.dart';
import 'package:nutri/app/pages/home/viewmodels/home_state_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/home_title_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/menu_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/overview_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/review_viewmodel.dart';
import 'package:nutri/app/services/shared_local_storage_service.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(
        titleViewModel: HomeTitleViewModel(),
        overviewViewModel: OverviewViewModel(
          repository: HomeRepository(
            provider: HomeProvider(storage: SharedLocalStorageService()),
          ),
        ),
        menuViewModel: MenuViewModel(
          repository: HomeRepository(
            provider: HomeProvider(
              storage: SharedLocalStorageService(),
            ),
          ),
        ),
        reviewViewModel: ReviewViewModel(),
        homeStateViewModel: HomeStateViewModel(),
        // repository: HomeRepository(
        //   provider: HomeProvider(
        //     storage: SharedLocalStorageService(),
        //   ),
        // ),
      ),
    );
  }
}
