import 'package:flutter/material.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';
import 'package:nutri/app/pages/home/viewmodels/home_menu_viewmodel.dart';
import 'package:nutri/app/pages/home/viewmodels/home_state_viewmodel.dart';

class HomeMenuViewController {
  //TODO: Fazer isso com as outras views
  final HomeMenuViewModel menuViewModel;
  final HomeStateViewModel stateViewModel;

  HomeMenuViewController(
      {required this.menuViewModel, required this.stateViewModel});

  PageController get pageController => menuViewModel.pageController;
  List<MenuModel> get menuList => menuViewModel.menuList;

  onDonePressed() => menuViewModel.onMenuDone();
  onSkippedPressed() => menuViewModel.onMenuSkipped();

  onMenuPageChanged(int idx) async {
    if (idx >= 4) stateViewModel.changeStateToReview();
  }
}
