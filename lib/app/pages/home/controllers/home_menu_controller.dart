import 'package:flutter/material.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';
import 'package:nutri/app/pages/home/viewmodels/menu_viewmodel.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/home/viewmodels/review_card_viewmodel.dart';

class HomeMenuController {
  //DONE: REVISAR AINDA
  final MenuViewModel menuViewModel;
  final ReviewCardViewModel reviewViewModel;

  HomeMenuController({
    required this.menuViewModel,
    required this.reviewViewModel,
  });

  final menuList = <MenuModel>[].obs;

  late PageController pageController;

  onDonePressed() {
    _nextMenuItem(true);
  }

  onSkippedPressed() {
    _nextMenuItem(false);
  }

  _nextMenuItem(bool val) {
    var pgIdx = pageController.page!.toInt();
    _saveMenuOptions(pgIdx, val);
    pageController.nextPage(
      duration: Duration(microseconds: 100),
      curve: Curves.ease,
    );
  }

//TODO: Como vou corrigir isso?
  // Esse cara está salvando os reviews aqui
  // Porem existe um viewmodel de review, que é o responsável pelas coisas do review
  // Ele quem deve ser o responsável por algumas obrigações que estão aqui
  _saveMenuOptions(int idx, bool done) {
    if (idx + 1 <= 3) menuViewModel.setMenuPageIndex(idx + 1);
    reviewViewModel.setReview(menuList[idx], done);
  }

  init() async {
    int menuIndex = await menuViewModel.fetchMenuPageIndex();
    pageController = PageController(initialPage: menuIndex);
    menuList.assignAll(
      await menuViewModel.fetchMenuList(
        DateTime.now().weekday,
      ),
    );
  }
}
