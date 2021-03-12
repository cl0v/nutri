import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/home/components/extra_food_selector.dart';
import 'package:nutri/app/modules/home/components/main_food_selector.dart';
import 'package:nutri/app/modules/home/components/overview_card.dart';
import 'package:nutri/app/modules/home/components/review_card.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';

class HomeBody extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      onPageChanged: controller.onPageChanged,
      itemBuilder: (c, idx) => Obx(() {
        if (controller.homeBodyState == HomeBodyState.Review)
          return ReviewCard();
        else if (controller.homeBodyState == HomeBodyState.Overview)
          return OverviewCard(items:controller.overViewMeals);
        else if (controller.homeBodyState == HomeBodyState.TomorrowOverView)
          return OverviewCard(items:[]); // TODO: Passar a lista de refeições (Apenas o prato principal e qual refeição mealType)
        else if (controller.homeBodyState == HomeBodyState.Meals)
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Obx(
                    () => Text(
                      '${controller.mealCategory}',
                      style: Get.textTheme!.headline5!
                          .copyWith(color: Colors.white),
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
          );
        else
          return Center(
            child: CircularProgressIndicator(),
          );
      }),
    );
  }
}
