import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'home_controller.dart';
import 'components/food_banner_card_widget.dart';

class HomePage extends GetView<HomeController> {
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
              onPressed: controller.homeTitleController.previewBtnEnabled
                  ? controller.homeTitleController.onPreviewDayPressed
                  : null,
            ),
            Text(controller.homeTitleController.title),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: controller.homeTitleController.nextBtnEnabled
                  ? controller.homeTitleController.onNextDayPressed
                  : null,
            ),
          ],
        ),
      );

  body() {
    return Obx(
      () => controller.homeCardList.length > 0
          ? SafeArea(
              child: ListView.builder(
                itemCount:
                    controller.homeCardList.length,
                itemBuilder: (ctx, idx) {
                  return FoodBannerCardWidget(
                    image: controller
                        .homeCardList[idx].img,
                    title: controller
                        .homeCardList[idx].title,
                    type: controller
                        .homeCardList[idx]
                        .mealTypeToString(),
                    onBannerTapped: () => controller.onBannerTapped(idx),
                  );
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
