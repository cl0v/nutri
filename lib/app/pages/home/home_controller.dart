import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nutri/app/pages/home/meal_card_model.dart';
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

  final IHomeTitleController homeTitleController = HomeTitleController()
    ..init();
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
        .fetchMealCardList(homeTitleController.dateAsString));
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
      'buttonsEnabled': buttonsEnabled,
      'day': homeTitleController.dateAsString,
    });
    if (response == null) return;
    if (response)
      mealCard.status = MealCardStatus.Done;
    else
      mealCard.status = MealCardStatus.Skipped;
    update();
    mealCardViewModel.saveMealCard(
      homeTitleController.dateAsString,
      mealCard,
    );
  }
}

abstract class IHomeTitleController {
  String get title;
  String get todayAsString;
  String get dateAsString;
  TitleButton get previewButton;
  TitleButton get nextButton;
  RxInt get showingDayIndex;
  //TODO: Tentar remover [showingDayIndex]
}

class TitleButton {
  bool isEnabled;
  VoidCallback onPressed;

  TitleButton({
    required this.isEnabled,
    required this.onPressed,
  });
}

class HomeTitleController implements IHomeTitleController {
  RxString _title = 'HOJE'.obs;
  String get title => _title.value ?? 'Carregando';


  //TODO: Essa chave estar aqui talvez nao seja ideal
  String get todayAsString =>
      '${_todayDateTime.day}/${_todayDateTime.month}/${_todayDateTime.year}';
  String get dateAsString =>
      '${_showingDateTime.day}/${_showingDateTime.month}/${_showingDateTime.year}';

  DateTime _todayDateTime = DateTime.now();
  late DateTime _showingDateTime = DateTime.now();

  late TitleButton previewButton;
  late TitleButton nextButton;

  init() {
    previewButton =
        TitleButton(isEnabled: false, onPressed: onPreviewDayPressed);
    nextButton = TitleButton(isEnabled: true, onPressed: onNextDayPressed);
  }

  RxInt showingDayIndex = DateTime.now().weekday.obs;

  int _dayIndex = 0;

  Function? onPreviewDayPressed() {
    _showingDateTime = _showingDateTime.subtract(Duration(days: 1));
    _showDay(_dayIndex--);
  }

  Function? onNextDayPressed() {
    _showingDateTime = _showingDateTime.add(Duration(days: 1));
    _showDay(_dayIndex++);
  }

  _showDay(_) async {
    _updateTitle();
    if (_dayIndex <= 0) {
      previewButton.isEnabled = false;
    } else {
      previewButton.isEnabled = true;
    }
    if (_dayIndex >= 6) {
      nextButton.isEnabled = false;
    } else {
      nextButton.isEnabled = true;
    }
  }

  _updateTitle() {
    _title.value =
        getDayTitle(_showingDateTime.difference(_todayDateTime).inDays);

    showingDayIndex.value = _showingDateTime.difference(_todayDateTime).inDays;
  }

  String getDayTitle(val) {
    switch (val) {
      case 1:
        return 'AMANHÃ';
      case -1:
        return 'ONTEM';
      case 0:
        return 'HOJE';
      default:
        return _getDayOfTheWeekString(_showingDateTime.weekday);
    }
  }

  String _getDayOfTheWeekString(int weekday) {
    switch (weekday) {
      case 1:
        return 'SEGUNDA';
      case 2:
        return 'TERÇA';
      case 3:
        return 'QUARTA';
      case 4:
        return 'QUINTA';
      case 5:
        return 'SEXTA';
      case 6:
        return 'SÁBADO';
      case 7:
        return 'DOMINGO';
    }
    return 'HOJE';
  }
}
