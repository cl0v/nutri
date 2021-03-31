import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nutri/app/pages/home/components/home_title_bar_widget.dart';
import 'package:nutri/app/pages/home/controllers/home_controller.dart';
import 'package:nutri/app/pages/home/models/home_state_model.dart';

import 'package:nutri/app/pages/home/views/menu_view.dart';
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
            isNextBtnDisabled: controller.homeTitleController.nextBtnDisabled,
            isPreviewBtnDisabled:
                controller.homeTitleController.previewBtnDisabled,
          ),
        ),
      ),
      body: Obx(
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
                () => controller
                            .homeOverviewViewController.overViewList.length >
                        0
                    ? OverviewView(
                        items:
                            controller.homeOverviewViewController.overViewList)
                    : Center(child: CircularProgressIndicator()),
              );
            case HomeState.Menu:
              return Obx(
                () => controller.homeMenuViewController.menuList.length > 0
                    ? MenuView(
                        menuList: controller.homeMenuViewController.menuList,
                        pageController:
                            controller.homeMenuViewController.pageController,
                        onPageChanged: controller.homeMenuViewController.onMenuPageChanged,
                      )
                    : Center(child: CircularProgressIndicator()),
              );
            default:
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
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
                  case HomeState.Menu:
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.resolveWith(
                                  (states) => Size(120, 36)),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Colors.red)),
                          onPressed: controller
                              .homeMenuViewController.onSkippedPressed,
                          child: Text('Pulei'),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.resolveWith(
                                  (states) => Size(120, 36)),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Colors.green)),
                          onPressed:
                              controller.homeMenuViewController.onDonePressed,
                          child: Text('Concluí'),
                        ),
                      ],
                    );
                  default:
                    return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
