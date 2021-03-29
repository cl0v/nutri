import 'package:flutter/material.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/home/viewmodels/home_diet_viewmodel.dart';

class HomeMenuViewModel {
  final menuList = <MenuModel>[].obs;

  final HomeDietViewModel viewModel;
  final ILocalStorage storage;

  late PageController pageController;

  final String _menuIndexKey = 'menuIndex';
  String get menuIndexKey =>
      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day.toString()}/$_menuIndexKey';

  HomeMenuViewModel({
    required this.viewModel,
    required this.storage,
  });

  init() async {
    int menuIndex = await storage.get(menuIndexKey) ??
        0; //Responsabilidade de alguem que tem acesso aos dados da home por completo
    pageController = PageController(initialPage: menuIndex);
    menuList.assignAll(await viewModel.getMenuList(DateTime.now().weekday));
  }

  onMenuDone() {
    _nextMenuItem(true);
  }

  onMenuSkipped() {
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
    if (idx + 1 <= 3) storage.put(menuIndexKey, idx + 1);
    var overview = menuList[idx].meal;
    viewModel.setReview(overview, done);
  }
}
