import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nutri/app/modules/home/components/extra_food_selector.dart';
import 'package:nutri/app/modules/home/components/main_food_selector.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';

class MenuPage extends StatelessWidget {
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      onPageChanged: controller.onPageChanged,
      itemBuilder: (c, idx) => SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Obx(
                () => Text(
                  '${controller.mealCategory}',
                  style:
                      Get.textTheme!.headline5!.copyWith(color: Colors.white),
                ),
              ),
              Obx(() => controller.isMainFoodsReady.value!
                  ? MainFoodSelector(
                      selectedFoodImg: controller
                          .mainFoodsAvailable[
                              controller.selectedMainFoodIdx.value]
                          .img,
                      selectedFoodTitle: controller
                          .mainFoodsAvailable[
                              controller.selectedMainFoodIdx.value]
                          .title,
                          foods: controller.mainFoodsAvailable,
                          onTap: controller.onMainFoodTapped,
                          isSelected: controller.isMainFoodSelected,
                    )
                  : Container()),
              Divider(),
              Obx(
                () => controller.extraFoodsAvailable.isNotEmpty
                    ? ExtraFoodSelector()
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
