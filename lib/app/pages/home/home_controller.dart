import 'package:get/get.dart';
import 'package:nutri/app/pages/home/helpers/home_title_helper.dart';
import 'package:nutri/app/pages/home/home_card_model.dart';
import 'package:nutri/app/pages/home/meal_card_viewmodel.dart';
import 'package:nutri/app/routes/app_pages.dart';

abstract class IHomeController {
  void onBannerTapped(MealCardModel mealCard);
  late final IMealCardBloc mealCardViewModel;
}

class HomeController extends GetxController implements IHomeController {
  @override
  IMealCardBloc mealCardViewModel;

  HomeController({
    required this.mealCardViewModel,
  });

  final IHomeTitleController homeTitleController = HomeTitleController()..init();
  //Criar interface e expor os parametros por aq?

  final RxList<MealCardModel> homeCardList = <MealCardModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchHomeCardList();

    ever(homeTitleController.showingDayIndex, _onDayChanged);
  }

  _onDayChanged(_) async {
    homeCardList.assignAll(await mealCardViewModel
        .fetchMealCardList(homeTitleController.dayAsString));
  }

  _fetchHomeCardList() async {
    homeCardList.assignAll(
      await mealCardViewModel
          .fetchMealCardList(homeTitleController.todayAsString),
    );
  }

  @override
  Future<void> onBannerTapped(MealCardModel mealCard) async {
    //TODO: Restringir outros dias de preencher
    var buttonsEnabled = mealCard.status == MealCardStatus.None;
    if (!buttonsEnabled) return;
    var response = await Get.toNamed(Routes.MEAL, arguments: {
      'meal': mealCard,
      'done': buttonsEnabled,
    });
    switch (response) {
      case true:
        mealCard.status = MealCardStatus.Done;
        break;
      case false:
        mealCard.status = MealCardStatus.Skipped;
        break;
      // default:
      // homeCardList[idx].status = MealCardStatus.None;
      //FIXME: Essa linha Estou gerando um bug intencional, quando aperto o botao para voltar, ele remove o estado ja concluido
    }
    update();
    mealCardViewModel.saveMealCard(
      homeTitleController.dayAsString,
      mealCard,
    );
  }
}

abstract class IHomeTitleController {
  String get title;
  String get todayAsString;
  String get dayAsString;
  bool get previewBtnEnabled;
  bool get nextBtnEnabled;
  RxInt get showingDayIndex;
  Function? onPreviewDayPressed();
  Function? onNextDayPressed();
  Function? onBackToTodayPressed();
}

class HomeTitleController implements IHomeTitleController {
  final HomeTitleHelper titleHelper = HomeTitleHelper();

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
