import 'package:get/get.dart';
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
import 'package:nutri/app/repositories/pe_diet_repository.dart';

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

  late IHomeStateVM homeStateViewModel;

  final HomeTitleController homeTitleController = HomeTitleController()..init();
  HomeState get state => homeStateViewModel.homeState.value!;

  showMealsCard() {
    homeStateViewModel.onOverViewNextState();
    homeTitleController.onBackToTodayPressed();
  }

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

    _fetchHomeState();

    ever(homeStateViewModel.homeState, _onStateChanded);
    ever(homeTitleController.showingDayIndex, _onDayChanged);
  }

  _fetchHomeState() async {
    homeStateViewModel.setHomeState = await homeStateViewModel.fetchHomeState();
  }

  _onDayChanged(int day) async {
    if (day == DateTime.now().weekday) {
      homeOverviewViewController.isTodayOverview = true;
      homeStateViewModel.changeStateWhithoutSave(
        await homeStateViewModel.fetchHomeState(),
      );
    } else {
      homeOverviewViewController.isTodayOverview = false;
      homeStateViewModel.changeStateWhithoutSave(HomeState.Overview);
    }

    //TODO: Esse day nao funcionará

    homeOverviewViewController
        .changeOverview(homeTitleController.showingDayDate);
  }

  _onStateChanded(HomeState? state) async {
    switch (state) {
      case HomeState.Overview:
        homeOverviewViewController
            .init(homeTitleController.todayDate); //TODO: Criar um getter
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
        homeMenuViewController.init(homeTitleController.todayDate);
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
