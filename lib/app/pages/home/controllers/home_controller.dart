import 'package:get/get.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/models/food_model.dart';
import 'package:nutri/app/pages/home/controllers/home_menu_view_controller.dart';
import 'package:nutri/app/pages/home/controllers/home_overview_view_controller.dart';
import 'package:nutri/app/pages/home/controllers/home_review_view_controller.dart';
import 'package:nutri/app/pages/home/controllers/home_title_controller.dart';
import 'package:nutri/app/pages/home/models/home_state_model.dart';
import 'package:nutri/app/pages/home/viewmodels/home_diet_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/home_state_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/home_title_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/home_menu_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/overview_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/review_viewmodel.dart';

class HomeController extends GetxController {
  final ILocalStorage storage;
  final HomeDietViewModel homeDietViewModel;
  HomeController({
    required this.homeDietViewModel,
    required this.storage,
    required this.homeStateViewModel,
  });

// title

// Criar controller pra a menu view e passar os parametros por contrutor
// final HomeMenuController homeMenuController()

  late HomeTitleController homeTitleController;

  late HomeMenuViewController homeMenuViewController;

  late HomeOverviewViewController homeOverviewViewController;

  late HomeReviewViewController homeReviewViewController;

// review view

// home state
  final HomeStateViewModel homeStateViewModel;
  Rx<HomeState> get homeState => homeStateViewModel.homeStateModel.state;
  HomeState get state => homeStateViewModel.homeStateModel.state.value!;

  showMealsCard() => homeStateViewModel.changeState(HomeState.Menu);

  @override
  void onInit() {
    super.onInit();

    homeTitleController = HomeTitleController(
      titleViewModel: HomeTitleViewModel(),
    );

    homeOverviewViewController = HomeOverviewViewController(
      overviewViewModel: OverviewViewModel(
        homeDietViewModel: homeDietViewModel,
      ),
    );
    homeMenuViewController = HomeMenuViewController(
      stateViewModel: homeStateViewModel,
      menuViewModel: HomeMenuViewModel(
        storage: storage,
        viewModel: homeDietViewModel,
      ),
    );

    homeReviewViewController = HomeReviewViewController(
      reviewViewModel: ReviewViewModel(
        homeDietViewModel: homeDietViewModel,
      ),
    );

    ever(homeState, _onStateChanded);
    ever(homeTitleController.showingDayIndex, _onDayChanged);
    homeStateViewModel.init();
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
    homeOverviewViewController.overviewViewModel.changeOverview(day);
  }

  _onStateChanded(HomeState? state) {
    switch (state) {
      case HomeState.Overview:
        homeOverviewViewController.overviewViewModel.init();
        break;
      case HomeState.Menu:
        homeMenuViewController.menuViewModel.init();
        break;
      case HomeState.Review:
        homeReviewViewController.reviewViewModel.init();
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

  // Menu //

//TODO: Remover a selecao dos extras nesse formato
  final _selectedExtrasList = <int>[].obs;
  List<int> get selectedExtrasList => _selectedExtrasList;
  final extraFoodsAvailable = <FoodModel>[].obs;
  List<FoodModel> selectedExtras = [];
  final _extrasAmount = 3.obs;
  int get extrasAmount => _extrasAmount.value;

  getSelectedIndex(int idx) => _selectedExtrasList.contains(idx);

  onExtraTapped(int idx) {
    if (!_selectedExtrasList.contains(idx) &&
        _selectedExtrasList.length < extrasAmount) {
      _selectedExtrasList.add(idx);
      selectedExtras.add(extraFoodsAvailable[idx]);
      return true;
    } else {
      _selectedExtrasList.remove(idx);
      selectedExtras.remove(extraFoodsAvailable[idx]);
      return false;
    }
  }
}
