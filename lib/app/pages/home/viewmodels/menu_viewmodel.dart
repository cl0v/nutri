import 'package:flutter/material.dart';
import 'package:nutri/app/interfaces/repositories/diet_interface.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';
import 'package:get/get.dart';

class MenuViewModel {
  final menuList = <MenuModel>[].obs;

  final IDiet repository;
  final ILocalStorage storage;

  late PageController pageController;

  final String _menuIndexKey = 'menuIndex';
  String get menuIndexKey => '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day.toString()}/$_menuIndexKey';


  MenuViewModel({
    required this.repository,
    required this.storage,
  });

  init() async {
    int menuIndex = await storage.get(menuIndexKey) ?? 0;
    pageController = PageController(initialPage: menuIndex);
    menuList.assignAll(await repository.getMenuList());
  }

  

  nextMenuItem(bool val) {
    var pgIdx = pageController.page!.toInt();
    _saveMenuOptions(pgIdx, val);
    pageController.nextPage(
      duration: Duration(microseconds: 100),
      curve: Curves.ease,
    );
  }

  _saveMenuOptions(int idx, bool done) {
    if(idx + 1 <= 3)
      storage.put(menuIndexKey, idx + 1);
    var overview = menuList[idx].overview;
    repository.setReview(overview, done);
  }
}
