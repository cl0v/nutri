import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/pages/home/models/home_state_model.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';
import 'package:nutri/app/pages/home/models/overview_model.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';
import 'package:nutri/app/pages/home/viewmodels/home_state_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/home_title_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/menu_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/overview_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/review_viewmodel.dart';

class HomeController extends GetxController {
  HomeController({
    required this.titleViewModel,
    required this.overviewViewModel,
    required this.menuViewModel,
    required this.reviewViewModel,
    required this.homeStateViewModel,
  });

// title
  final HomeTitleViewModel titleViewModel;

  String? get title => titleViewModel.model.title.value;
  bool? get previewBtnDisabled => titleViewModel.model.previewBtnDisabled.value;
  bool? get nextBtnDisabled => titleViewModel.model.nextBtnDisabled.value;
  RxInt get showingDayIndex => titleViewModel.day;
  int get todayIndex => titleViewModel.todayIndex;

  void onPreviewDayPressed() => titleViewModel.previewDay();
  void onNextDayPressed() => titleViewModel.nextDay();

// overview view
  final OverviewViewModel overviewViewModel;
  List<OverviewModel> get overViewList => overviewViewModel.overviewList;

  bool isTodayOverview = true;

// menu view
  final MenuViewModel menuViewModel;
  PageController get pageController => menuViewModel.pageController;
  List<MenuModel> get menuList => menuViewModel.menuList;
  List<bool> get doneList => menuViewModel.doneList;

  onDonePressed() => menuViewModel.nextMenuItem(true);
  onSkippedPressed() => menuViewModel.nextMenuItem(false);

  onMenuPageChanged(int idx) async {
    if (idx >= 4) homeStateViewModel.changeState(HomeState.Review);
  }

// review view
  final ReviewViewModel reviewViewModel;
  List<ReviewModel> get reviewList => reviewViewModel.reviewList;

// home state
  final HomeStateViewModel homeStateViewModel;
  Rx<HomeState> get homeState => homeStateViewModel.homeStateModel.state;
  HomeState get state => homeStateViewModel.homeStateModel.state.value!;

  showMealsCard() => homeStateViewModel.changeState(HomeState.Menu);

  @override
  void onInit() {
    super.onInit();
    ever(homeState, onStateChanded);
    ever(showingDayIndex, onDayChanged);
    homeStateViewModel.init();
  }

  onDayChanged(int day) async {
    if (day == todayIndex) {
      isTodayOverview = true;
      homeStateViewModel
          .changeStateWhithoutSave(await homeStateViewModel.getTodayState());
    } else {
      isTodayOverview = false;
      homeStateViewModel.changeStateWhithoutSave(HomeState.Overview);
    }
    overviewViewModel.changeOverview(day);
  }

  onStateChanded(HomeState? state) {
    switch (state) {
      case HomeState.Overview:
        overviewViewModel.init();
        break;
      case HomeState.Menu:
        menuViewModel.init();
        break;
      case HomeState.Review:
        reviewViewModel.init();
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
