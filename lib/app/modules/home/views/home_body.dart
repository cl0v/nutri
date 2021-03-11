import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/home/components/extra_food_selector.dart';
import 'package:nutri/app/modules/home/components/main_food_selector.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';

class HomeBody extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      itemBuilder: (c, idx) => SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Obx(
                () => Text(
                  '${controller.mealCategory}',
                  style: Get.textTheme!.headline5!.copyWith(color: Colors.white),
                ),
              ),
              MainFoodSelector(),
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
