import 'package:get/get.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/helpers/home_title_helper.dart';
import 'package:nutri/app/pages/home/models/home_card_model.dart';
import 'package:nutri/app/pages/home/viewmodels/home_card_viewmodel.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';

abstract class IHomeController {
  //Recebe essa lista do banco de dados
  // List<HomeCardModel> homeCardList = [];
  //Controller do titulo
  late final HomeTitleController homeTitleController;
  // Ação ao clicar no banner
  void onBannerTapped(int idx);
  late final IMealCardBloc homeCardViewModel;
}

class HomeController extends GetxController implements IHomeController {
  final ILocalStorage storage;
  final IDiet diet;

  HomeController({
    required this.diet,
    required this.storage,
    required this.homeCardViewModel,
  });

  final HomeTitleController homeTitleController = HomeTitleController()..init();

  final RxList<MealCardModel> homeCardList = <MealCardModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeCardList();

    // ever(homeTitleController.showingDayIndex, _onDayChanged);
  }

  fetchHomeCardList() async {
    homeCardList.assignAll(
      await homeCardViewModel
          .fetchHomeCardList(homeTitleController.todayAsString),
    );
  }

  @override
  void onBannerTapped(int idx) {
    // TODO: implement onBannerTapped
    print('tocado man');
    Get.toNamed(Routes.MEAL, arguments: {'meal': homeCardList[idx]});
  }

  @override
  set homeTitleController(HomeTitleController _homeTitleController) {
    // TODO: implement homeTitleController
  }

  @override
  IMealCardBloc homeCardViewModel;
}

class HomeTitleController {
  final HomeTitleHelper titleHelper = HomeTitleHelper();

  HomeTitleController();

  RxString _title = 'HOJE'.obs;
  String get title => _title.value ?? 'Carregando';

  String get todayAsString =>
      '${_todayDateTime.day}/${_todayDateTime.month}/${_todayDateTime.year}';
  String get dayAsString =>
      '${_showingDateTime.day}/${_showingDateTime.month}/${_showingDateTime.year}';

  DateTime _todayDateTime = DateTime.now();
  late DateTime _showingDateTime;

  bool previewBtnEnabled = false; // Trocar para enabled
  bool nextBtnEnabled = true; // Trocar para enabled

  RxInt showingDayIndex = DateTime.now().weekday.obs;

  int todayIndex = DateTime.now().weekday;

  int _dayIndex = 0;

  void init() {
    _showingDateTime = DateTime.now();
  }

  Function? onPreviewDayPressed() {
    _showingDateTime = _showingDateTime.subtract(Duration(days: 1));
    _showDay(_dayIndex--);
  }

  Function? onNextDayPressed() {
    _showingDateTime = _showingDateTime.add(Duration(days: 1));
    _showDay(_dayIndex++);
  }

  Function? onBackToTodayPressed() {
    _showingDateTime = _todayDateTime;
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
