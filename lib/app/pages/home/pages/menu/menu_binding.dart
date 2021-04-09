import 'package:get/get.dart';
import 'package:nutri/app/pages/home/pages/menu/menu_card_viewmodel.dart';
import 'package:nutri/app/providers/food_provider.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';

import 'menu_controller.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MenuController>(
      MenuController(
        menuCardBloc: MenuCardViewModel(
          diet: PeDietRepository(
            foodProvider: FoodProvider(),
          ),
        ),
      ),
    );
  }
}
