import 'package:get/get.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/controllers/home_menu_controller.dart';
import 'package:nutri/app/pages/home/controllers/home_overview_controller.dart';
import 'package:nutri/app/pages/home/controllers/home_review_controller.dart';
import 'package:nutri/app/pages/home/helpers/home_title_helper.dart';
import 'package:nutri/app/pages/home/models/home_card_model.dart';
import 'package:nutri/app/pages/home/models/home_state_model.dart';
import 'package:nutri/app/pages/home/viewmodels/home_state_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/meal_card_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/menu_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/review_card_viewmodel.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';

abstract class IHomeController {
  late final List<HomeCardModel>
      homeCardList; //Recebe essa lista do banco de dados
  late HomeTitleController homeTitleController; //Controller do titulo
  void onBannerTapped(int idx); // Ação ao clicar no banner
  late HomeOverviewController homeOverviewViewController; //TODO: Remover
}

class HomeController extends GetxController implements IHomeController {
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

    ever(homeTitleController.showingDayIndex, _onDayChanged);
    ever(homeStateViewModel.homeState, _onStateChanded);
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
    }}

    _onStateChanded(HomeState? state) async {
      switch (state) {
        case HomeState.Overview:
          homeOverviewViewController
              .init(homeTitleController.todayDate); //TODO: Criar um getter
          break;
        case HomeState.Loading:
          // TODO: Handle this case.
          break;
        case HomeState.Menu:
          // TODO: Handle this case.
          break;
        case HomeState.Review:
          // TODO: Handle this case.
          break;
        default:
      }
    

    //TODO: Esse day nao funcionará

    homeOverviewViewController
        .changeOverview(homeTitleController.showingDayDate);
  }

  @override
  late List<HomeCardModel> homeCardList;

  @override
  set homeTitleController(HomeTitleController _homeTitleController) {
    // TODO: implement homeTitleController
  }

  @override
  void onBannerTapped(int idx) {
    // TODO: implement onBannerTapped
  }
}

class HomeTitleController {
  final HomeTitleHelper titleHelper = HomeTitleHelper();

  HomeTitleController();

  RxString _title = 'HOJE'.obs;
  String get title => _title.value ?? 'Carregando';

  String get todayDate =>
      '${_todayDate.day}/${_todayDate.month}/${_todayDate.year}';
  String get showingDayDate =>
      '${_showingDayDate.day}/${_showingDayDate.month}/${_showingDayDate.year}';

  DateTime _todayDate = DateTime.now();
  late DateTime _showingDayDate;

  bool previewBtnEnabled = false; // Trocar para enabled
  bool nextBtnEnabled = true; // Trocar para enabled

  RxInt showingDayIndex = DateTime.now().weekday.obs;

  int todayIndex = DateTime.now().weekday;

  int _dayIndex = 0;

  init() {
    _showingDayDate = DateTime.now();
  }

  Function? onPreviewDayPressed() {
    _showingDayDate = _showingDayDate.subtract(Duration(days: 1));
    _showDay(_dayIndex--);
  }

  Function? onNextDayPressed() {
    _showingDayDate = _showingDayDate.add(Duration(days: 1));
    _showDay(_dayIndex++);
  }

  Function? onBackToTodayPressed() {
    _showingDayDate = _todayDate;
    _showDay(_dayIndex = 0);
  }

  _showDay(_) async {
    _setShowingDayIndex();
    if (_dayIndex <= 0) {
      previewBtnEnabled = false;
    } else {
      previewBtnEnabled = true;
    }
    if (_dayIndex >= 6) {
      nextBtnEnabled = false;
    } else {
      nextBtnEnabled = true;
    }
    _title.value = titleHelper.getDayTitle(todayIndex, _dayIndex);
  }

  _setShowingDayIndex() {
    showingDayIndex.value = (todayIndex + _dayIndex - 1) % 7 + 1;
  }
}
