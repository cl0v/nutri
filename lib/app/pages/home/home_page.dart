import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nutri/app/pages/home/controllers/home_controller.dart';
import 'package:nutri/app/pages/home/enums/home_body_state_enum.dart';

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: controller.isPreviewBtnDisabled.value!
                  ? null
                  : controller.onPreviewDayPressed,
            ),
            Text(controller.getDayTitle()),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: controller.isNextBtnDisabled.value!
                  ? null
                  : controller.onNextDayPressed,
            ),
          ],
        ),
      ),
      body: Obx(
        () {
          switch (controller.homeBodyState) {
            case HomeBodyState.Loading:
              return Center(child: CircularProgressIndicator());
            case HomeBodyState.Review:
              return Obx(
                () => controller.isReviewReady.value!
                    ? ReviewView(items: controller.reviewList) //TODO: Implement reviewpage
                    // ? CircularProgressIndicator()
                    : Center(child: CircularProgressIndicator()),
              );
            case HomeBodyState.Overview:
              return Obx(
                () => controller.isOverViewReady.value!
                    ? OverviewView(items: controller.overViewList)
                    : Center(child: CircularProgressIndicator()),
              );
            case HomeBodyState.Menu:
              return Obx(
                () => controller.isMenuReady.value!
                    ? MenuView(
                        menuList: controller.menuList,
                        mealModel: controller.overViewList,
                        pageController: controller.pageController,
                        onPageChanged: controller.onMenuPageChanged,
                        onExtraFoodTapped: controller.onExtraTapped
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
                switch (controller.homeBodyState) {
                  case HomeBodyState.Loading:
                    return Container();
                  case HomeBodyState.Overview:
                    return ElevatedButton(
                      onPressed: controller.showMealsCard,
                      child: Text('Vamos la'),
                    );
                  // case HomeBodyState
                  //     .Review: //FIXME: O botao nao permite aparecer caso n exista
                  //   return ElevatedButton(
                  //     onPressed: () {},
                  //     child: Text('Vamos la'),
                  //   );
                  case HomeBodyState.Menu:
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.resolveWith(
                                  (states) => Size(120, 36)),
                              backgroundColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.red)),
                          onPressed: controller.onSkippedPressed,
                          child: Text('Pulei'),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.resolveWith(
                                  (states) => Size(120, 36)),
                              backgroundColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.green)),
                          onPressed: controller.onDonePressed,
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
