import 'package:get/get.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/controllers/home_overview_controller.dart';
import 'package:nutri/app/pages/home/helpers/home_title_helper.dart';
import 'package:nutri/app/pages/home/models/home_card_model.dart';
import 'package:nutri/app/pages/home/viewmodels/home_card_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/meal_card_viewmodel.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';

abstract class IHomeController {
  late final List<HomeCardModel> homeCardList;
  //Recebe essa lista do banco de dados
  late final HomeTitleController homeTitleController; //Controller do titulo
  void onBannerTapped(int idx); // Ação ao clicar no banner
  late final IHomeCardBloc homeCardViewModel;
}

class HomeController extends GetxController implements IHomeController {
  final ILocalStorage storage;
  final IDiet diet;

  HomeController({
    required this.diet,
    required this.storage,
    required this.homeCardViewModel,
  });

  late HomeOverviewController homeOverviewViewController;


  final HomeTitleController homeTitleController = HomeTitleController()..init();

  late List<HomeCardModel> homeCardList;

  @override
  void onInit() {
    super.onInit();
    init();

    

    homeOverviewViewController = HomeOverviewController(
      mealCardViewModel: MealCardViewModel(
        diet: diet,
      ),
    );

    homeOverviewViewController.init(homeTitleController.todayDate);

    // _fetchHomeState();
    // ever(homeTitleController.showingDayIndex, _onDayChanged);
  }

  init() async {
    homeCardList = await homeCardViewModel.fetchHomeCardList();
  }

  // _fetchHomeState() async {
  //   homeStateViewModel.setHomeState = await homeStateViewModel.fetchHomeState();
  // }

  // _onDayChanged(int day) async {
  //   if (day == DateTime.now().weekday) {
  //     homeOverviewViewController.isTodayOverview = true;
  //     homeStateViewModel.changeStateWhithoutSave(
  //       await homeStateViewModel.fetchHomeState(),
  //     );
  //   } else {
  //     homeOverviewViewController.isTodayOverview = false;
  //     homeStateViewModel.changeStateWhithoutSave(HomeState.Overview);
  //   }

  //   homeOverviewViewController
  //       .changeOverview(homeTitleController.showingDayDate);
  // }

  @override
  void onBannerTapped(int idx) {
    // TODO: implement onBannerTapped
  }

  @override
  set homeTitleController(HomeTitleController _homeTitleController) {
    // TODO: implement homeTitleController
  }

  @override
  IHomeCardBloc homeCardViewModel;
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
