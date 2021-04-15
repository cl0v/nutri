import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nutri/app/pages/home/home_card_model.dart';

import 'home_controller.dart';
import 'components/food_banner_card_widget.dart';

class HomePage extends GetView<HomeController> {
  Color? getBannerColor(MealCardModel model) {
    switch (model.status) {
      case MealCardStatus.Done:
        return Colors.green.withOpacity(.4);
      case MealCardStatus.Skipped:
        return Colors.red.withOpacity(.4);
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: title(),
      ),
      body: body(),
    );
  }

  title() => Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: controller.homeTitleController.previewButton.isEnabled
                  ? controller.homeTitleController.previewButton.onPressed
                  : null,
            ),
            Text(controller.homeTitleController.title),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: controller.homeTitleController.nextButton.isEnabled
                  ? controller.homeTitleController.nextButton.onPressed
                  : null,
            ),
          ],
        ),
      );

  body() {
    return Obx(
      () => controller.homeCardList.length > 0
          ? SafeArea(
              child: Column(
                children: controller.homeCardList
                    .map<Widget>(
                      (mealCard) => Expanded(
                        child: GetBuilder<HomeController>(
                          builder: (_) {
                            return FoodBannerCardWidget(
                              image: mealCard.img,
                              title: mealCard.title,
                              type: mealCard.mealTypeToString(),
                              isTapabble:
                                  mealCard.status == MealCardStatus.None,
                              color: getBannerColor(mealCard),
                              onBannerTapped: () =>
                                  controller.onBannerTapped(mealCard),
                            );
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          : Container(),
    );
  }
}
