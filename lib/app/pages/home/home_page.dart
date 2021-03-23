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
        title: HomeTitleBarWidget(),
      ),
      body: Obx(
        () {
          switch (controller.state) {
            case HomeState.Loading:
              return Center(child: CircularProgressIndicator());
            case HomeState.Review:
              return Obx(
                () => controller.reviewList.length > 0
                    ? ReviewView(items: controller.reviewList)
                    : Center(child: CircularProgressIndicator()),
              );
            case HomeState.Overview:
              return Obx(
                () => controller.overViewList.length > 0
                    ? OverviewView(items: controller.overViewList)
                    : Center(child: CircularProgressIndicator()),
              );
            case HomeState.Menu:
              return Obx(
                () => controller.menuList.length > 0
                    ? MenuView(
                        menuList: controller.menuList,
                        pageController: controller.pageController,
                        onPageChanged: controller.onMenuPageChanged,
                        onExtraFoodTapped: controller.onExtraTapped)
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
                          onPressed: controller.onSkippedPressed,
                          child: Text('Pulei'),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.resolveWith(
                                  (states) => Size(120, 36)),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
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
