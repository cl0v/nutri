import 'package:flutter/material.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';
import 'package:nutri/app/pages/home/viewmodels/home_state_viewmodel.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/home/viewmodels/menu_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/review_card_viewmodel.dart';

class HomeMenuController {
  //DONE: REVISAR AINDA
  final IMenuVM menuViewModel;
  final IReviewCardSetter reviewViewModel;
  final IHomeStateVM homeStateViewModel;

  HomeMenuController({
    required this.menuViewModel,
    required this.reviewViewModel,
    required this.homeStateViewModel,
  });

  final menuList = <MenuModel>[].obs;

  late PageController pageController;

  init(String day) async {
    int menuIndex = await menuViewModel.fetchMenuIndex();
    pageController = PageController(initialPage: menuIndex);
    menuList.assignAll(
      await menuViewModel.fetchMenuList(day),
    );
  }

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

  _saveMenuOptions(int idx, bool done) {
    if (idx + 1 <= 3) menuViewModel.setMenuIndex(idx + 1);
    reviewViewModel.setReview(menuList[idx], done);
  }

  onMenuPageChanged(int idx) async {
    if (idx >= 4) homeStateViewModel.onMenuNextState();
  }
}
