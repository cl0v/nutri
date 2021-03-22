import 'package:flutter/material.dart';
import 'package:nutri/app/pages/home/models/old_menu_model.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/home/repositories/home_repository.dart';

class MenuViewModel {
  final menuList = <OldMenuModel>[].obs;
  List<bool> doneList = [];
  final HomeRepository repository;

  PageController pageController = PageController();
   

  MenuViewModel({required this.repository});

  init() async {
    menuList.assignAll(await repository.getMenuListFromPEDietSugestion());
  }

  nextMenuItem(bool val) {
    //TODO:Renomear
    doneList.add(val);
    pageController.nextPage(
      duration: Duration(microseconds: 100),
      curve: Curves.ease,
    );
  }

  saveMenuPageIndex(int idx){
    repository.setPageIndex(idx);
  }
}
