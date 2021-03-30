import 'package:get/get.dart';
import 'package:nutri/app/interfaces/providers/diet_interface.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/controllers/home_menu_view_controller.dart';
import 'package:nutri/app/pages/home/controllers/home_overview_view_controller.dart';
import 'package:nutri/app/pages/home/controllers/home_review_view_controller.dart';
import 'package:nutri/app/pages/home/controllers/home_title_controller.dart';
import 'package:nutri/app/pages/home/models/home_state_model.dart';
import 'package:nutri/app/pages/home/viewmodels/home_state_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/home_title_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/home_menu_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/overview_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/review_viewmodel.dart';

class HomeController extends GetxController {
  final ILocalStorage storage;
  final IDiet diet;

  HomeController({
    required this.diet,
    required this.storage,
  });

  late HomeTitleController homeTitleController;

  late HomeMenuViewController homeMenuViewController;

  late HomeOverviewViewController homeOverviewViewController;

  late HomeReviewViewController homeReviewViewController;

  late HomeStateViewModel homeStateViewModel;

  HomeState get state => homeStateViewModel.state.value!;

  showMealsCard() => homeStateViewModel.changeState(HomeState.Menu);

  @override
  void onInit() {
    super.onInit();

    homeTitleController = HomeTitleController(
      titleViewModel: HomeTitleViewModel(),
    );

    homeStateViewModel = HomeStateViewModel(
      storage: storage,
    );

    homeOverviewViewController = HomeOverviewViewController(
      overviewViewModel: OverviewViewModel(
        diet: diet,
      ),
    );

    homeReviewViewController = HomeReviewViewController(
      reviewViewModel: ReviewViewModel(
        storage: storage,
      ),
    );

    homeMenuViewController = HomeMenuViewController(
      stateViewModel: homeStateViewModel,
      menuViewModel: HomeMenuViewModel(
        setReview: homeReviewViewController.setReview,
        diet: diet,
        storage: storage,
      ),
    );

    homeStateViewModel.init();
    ever(homeStateViewModel.state, _onStateChanded);
    ever(homeTitleController.showingDayIndex, _onDayChanged);
  }

  _onDayChanged(int day) async {
    if (day == homeTitleController.todayIndex) {
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

  _onStateChanded(HomeState? state) {
    switch (state) {
      case HomeState.Overview:
        homeOverviewViewController.init();
        break;
      case HomeState.Menu:
        homeMenuViewController.init();
        break;
      case HomeState.Review:
        homeReviewViewController.init();
        break;
      default:
    }
  }

// Daqui pra baixo nao estou usando nada
  int selectedMainFoodIdx = 0;
  onMainFoodTapped(int idx) {
    //Se eu precisar salvar qual a proteina que o usuario escolheu
    selectedMainFoodIdx = idx;
  }
}
