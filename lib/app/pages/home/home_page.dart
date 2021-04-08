import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nutri/app/pages/home/components/home_title_bar_widget.dart';
import 'package:nutri/app/pages/home/controllers/home_controller.dart';
import 'package:nutri/app/pages/home/models/home_state_model.dart';

import 'package:nutri/app/pages/home/views/overview_view.dart';
import 'package:nutri/app/pages/home/views/review_view.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Obx(
          () => HomeTitleBarWidget(
            onNextDayPressed: controller.homeTitleController.onNextDayPressed,
            onPreviewDayPressed:
                controller.homeTitleController.onPreviewDayPressed,
            title: controller.homeTitleController.title,
            isNextBtnEnabled: controller.homeTitleController.nextBtnEnabled,
            isPreviewBtnEnabled:
                controller.homeTitleController.previewBtnEnabled,
          ),
        ),
      ),
      body: body(),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  body() {
    return Obx(
      () {
        switch (controller.state) {
          case HomeState.Loading:
            return Center(child: CircularProgressIndicator());
          case HomeState.Review:
            return Obx(
              () => controller.homeReviewViewController.reviewList.length > 0
                  ? ReviewView(
                      items: controller.homeReviewViewController.reviewList)
                  : Center(child: CircularProgressIndicator()),
            );
          case HomeState.Overview:
            return Obx(
              () => controller.homeOverviewViewController.overViewList.length >
                      0
                  ? OverviewView(
                      items: controller.homeOverviewViewController.overViewList,
                      onBannerTapped: () {
                        print('tocado');
                        //TODO: Implement
                      },
                    )
                  : Center(child: CircularProgressIndicator()),
            );

          default:
            return Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  bottomNavBar() {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Obx(
            () {
              switch (controller.state) {
                case HomeState.Loading:
                  return Container();
                case HomeState.Overview:
                  if (controller.homeOverviewViewController.isTodayOverview)
                    return ElevatedButton(
                      onPressed: controller.showMealsCard,
                      child: Text('Começar'),
                    );
                  else
                    return ElevatedButton(
                      onPressed:
                          controller.homeTitleController.onBackToTodayPressed,
                      child: Text('Ver hoje'),
                    );

                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
