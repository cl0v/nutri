import 'package:flutter/material.dart';
import 'package:nutri/app/interfaces/providers/diet_interface.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';
import 'package:get/get.dart';

class HomeMenuViewModel {
  final menuList = <MenuModel>[].obs;

  final ILocalStorage storage;
  final IDiet diet;

  late PageController pageController;
  Function(MenuModel, bool) setReview;
  //TODO: Modificar essa forma de chamar a funcao
  /*
  Estou precisando acessar um metodo que outro viewModel possui,
  logo estou passando por controller
  [_saveMenuOptions] quem está usando
  */

  final String _menuIndexKey = 'menuIndex';
  String get menuIndexKey =>
      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day.toString()}/$_menuIndexKey';

  HomeMenuViewModel({
    required this.storage,
    required this.diet,
    required this.setReview,
  });

  init() async {
    int menuIndex = await storage.get(menuIndexKey) ?? 0;
    pageController = PageController(initialPage: menuIndex);
    menuList.assignAll(await _buildMenuList());
  }

  _buildMenuList() async {
    int day = DateTime.now().weekday;
    return [
      MenuModel.fromDietModel((await diet.getBreakfast(day))),
      MenuModel.fromDietModel((await diet.getLunch(day))),
      MenuModel.fromDietModel((await diet.getSnack(day))),
      MenuModel.fromDietModel((await diet.getDinner(day))),
    ];
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

//TODO: Como vou corrigir isso?
    // Esse cara está salvando os reviews aqui
    // Porem existe um viewmodel de review, que é o responsável pelas coisas do review
    // Ele quem deve ser o responsável por algumas obrigações que estão aqui
  _saveMenuOptions(
    int idx,
    bool done,
  ) {
    
    if (idx + 1 <= 3) storage.put(menuIndexKey, idx + 1);
    var overview = menuList[idx];
    setReview(overview, done);
  }
}
