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
        switch (controller.homeBodyState) {
          case HomeBodyState.Review:
            return ReviewCard(items: controller.reviewMeals);
          case HomeBodyState.Overview:
            return OverviewCard(items: controller.overViewMeals);
          case HomeBodyState.OtherDayOverview:
            return OverviewCard(items: controller.overViewMealsOfOtherDay);
          case HomeBodyState.Loading:
            return Center(child: CircularProgressIndicator());
          case HomeBodyState.Meals:
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
          default:
            return Center(
              child: CircularProgressIndicator(),
            );
        }
      }),
    );
  }
}
