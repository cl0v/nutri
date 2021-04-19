import 'package:get/get.dart';
import 'package:nutri/app/pages/home/home_model.dart';

abstract class IMenuController {
  void onMainFoodTapped(int idx);
  void onExtraFoodTapped(List<int> idxList);
  void onDonePressed();
  void onSkipPressed();
}

class MenuController extends GetxController implements IMenuController {

  late HomeModel homeModel;
  bool buttonsEnabled = true;


  @override
  void onInit() {
    homeModel = Get.arguments['model'];
    buttonsEnabled = homeModel.status == Status.None;

    super.onInit();
  }

  @override
  void onExtraFoodTapped(List<int> idxList) {
    homeModel.selected.extraIdxList = idxList;

    // TODO: implement onExtraFoodTapped
  }

  @override
  void onMainFoodTapped(int idx) {
    homeModel.selected.mealIdx = idx;
  }

  @override
  void onDonePressed() async {
    Get.back(result: true);
  }

  @override
  void onSkipPressed() async {
    Get.back(result: false);
  }
}
