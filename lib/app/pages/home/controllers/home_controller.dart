import 'package:get/get.dart';
import 'package:nutri/app/interfaces/providers/diet_interface.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/controllers/home_menu_controller.dart';
import 'package:nutri/app/pages/home/controllers/home_overview_controller.dart';
import 'package:nutri/app/pages/home/controllers/home_review_controller.dart';
import 'package:nutri/app/pages/home/controllers/home_title_controller.dart';
import 'package:nutri/app/pages/home/models/home_state_model.dart';
import 'package:nutri/app/pages/home/viewmodels/home_state_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/menu_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/meal_card_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/review_card_viewmodel.dart';

class HomeController extends GetxController {
  final ILocalStorage storage;
  final IDiet diet;

  HomeController({
    required this.diet,
    required this.storage,
  });

  late HomeOverviewController homeOverviewViewController;

  late HomeMenuController homeMenuViewController;

  late HomeReviewController homeReviewViewController;

  late HomeStateViewModel homeStateViewModel;

  final HomeTitleController homeTitleController = HomeTitleController();
  HomeState get state => homeStateViewModel.state.value!;

  showMealsCard() => homeStateViewModel.changeState(HomeState.Menu);

  @override
  void onInit() {
    super.onInit();

    homeStateViewModel = HomeStateViewModel(
      storage: storage,
    );

    homeOverviewViewController = HomeOverviewController(
      mealCardViewModel: MealCardViewModel(
        diet: diet,
      ),
    );

    homeStateViewModel.init();

    ever(homeStateViewModel.state, _onStateChanded);
    ever(homeTitleController.showingDayIndex, _onDayChanged);
  }

  _onDayChanged(int day) async {
    if (day == DateTime.now().weekday) {
      homeOverviewViewController.isTodayOverview = true;
      homeStateViewModel.changeStateWhithoutSave(
        await homeStateViewModel.getTodayState(),
      );
    } else {
      homeOverviewViewController.isTodayOverview = false;
      homeStateViewModel.changeStateWhithoutSave(HomeState.Overview);
    }
    homeOverviewViewController.changeOverview(day);
  }

  _onStateChanded(HomeState? state) async {
    switch (state) {
      case HomeState.Overview:
        homeOverviewViewController.init();
        break;
      case HomeState.Menu:
        homeMenuViewController = HomeMenuController(
          homeStateViewModel: homeStateViewModel,
          reviewViewModel: ReviewCardViewModel(
            storage: storage,
          ),
          menuViewModel: MenuViewModel(
            diet: diet,
            storage: storage,
          ),
        );
        homeMenuViewController.init();
        break;
      case HomeState.Review:
        homeReviewViewController = HomeReviewController(
          reviewViewModel: ReviewCardViewModel(
            storage: storage,
          ),
        );
        homeReviewViewController.init();
        break;
      default:
    }
  }
}
