import 'package:get/get.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/pages/menu/menu_card_model.dart';

import 'menu_card_viewmodel.dart';

abstract class IMenuController {
  void onMainFoodTapped(int idx);
  void onExtraFoodTapped(List<int> idxList);
  void onDonePressed();
  void onSkipPressed();
}

class MenuController extends GetxController implements IMenuController {
  final IMenuCardBloc menuCardBloc;

  MenuController({required this.menuCardBloc});

  late final RxList<MenuCardModel> _menu = <MenuCardModel>[].obs;
  bool get menuHack => _menu.isNotEmpty;
  MenuCardModel get menu => _menu.first;
  RxBool _buttonsEnabled = true.obs;
  bool get buttonsEnabled => _buttonsEnabled.value!;

  late final _day;
  //TODO: Salvar os valores e remover a possibilidade de alteração apos salvo

  @override
  void onInit() {
    _mealModel = Get.arguments['meal'];
    _buttonsEnabled.value = Get.arguments['buttonsEnabled'];
    _day = Get.arguments['day'];
    init();
    super.onInit();
  }

  init() async {
    _menu.assignAll([await menuCardBloc.fetchMenuCardModel(_mealModel)]);
  }

  late MealModel _mealModel;
  MealModel get mealModel => _mealModel;

  @override
  void onExtraFoodTapped(List<int> idxList) {
    menu.selectedExtrasIndex = idxList;

    // TODO: implement onExtraFoodTapped
  }

  @override
  void onMainFoodTapped(int idx) {
    menu.selectedFoodIndex = idx;
    // TODO: implement onMainFoodTapped
  }

  @override
  void onDonePressed() {
    Get.back(result: true);
  }

  @override
  void onSkipPressed() {
    Get.back(result: false);
  }

  save() {
    
  }
}
