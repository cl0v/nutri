import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/home/home_model.dart';
import 'package:nutri/app/pages/home/home_viewmodel.dart';

import 'package:nutri/app/routes/app_pages.dart';

//TODO: Remover o menu viewmodel, o menu será passado por argumento atravez do home controller para o menuController
//TODO: A dieta será buildada aqui

abstract class IHomeController {
  void onBannerTapped(HomeModel mealCard);
  late IHomeBloc homeBloc;
}

class HomeController extends GetxController implements IHomeController {
  @override
  IHomeBloc homeBloc;

  HomeController({
    required this.homeBloc,
  });

  final IHomeTitleController homeTitleController = HomeTitleController()
    ..init();

  final RxList<HomeModel> homeModelList = <HomeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    ever(homeTitleController.showingDayIndex, _onDayChanged);
  }

  @override
  void onReady() async{
    super.onReady();
    homeModelList.assignAll(await homeBloc.homeModelList());
  }


  _onDayChanged(_) async {
    homeModelList.assignAll(await homeBloc.homeModelList());
  }

  @override
  Future<void> onBannerTapped(HomeModel homeModel) async {
    var response = await Get.toNamed(Routes.MEAL, arguments: {
      'model': homeModel,
    });
    if (response == null) return;
    if (response)
      homeModel.status = Status.Done;
    else
      homeModel.status = Status.Skipped;
    update();
    //TODO: Removi temporariamente, pois um está sobrescrevendo o outro
    //TODO: Nao vai funcionar até descomentar essas linhas
    // mealCardViewModel.saveMealCard(
    //   homeTitleController.dateAsString,
    //   mealCard,
    // );
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
