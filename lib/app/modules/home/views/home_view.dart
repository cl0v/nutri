import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';

import 'package:nutri/app/modules/home/views/home_body.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () => controller.showHomeContent
              ? Scaffold(
                  body: HomeBody(),
                  extendBodyBehindAppBar: true,
                  bottomNavigationBar: BottomAppBar(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Obx(
                      () {
                        switch (controller.homeBodyState) {
                          case HomeBodyState.Overview:
                            return ElevatedButton(
                                onPressed: controller.showMealsCard,
                                child: Text('Vamos la'),
                                style: ButtonStyle(
                                  minimumSize:
                                      MaterialStateProperty.resolveWith(
                                          (states) => Size(120, 42)),
                                ),
                            );
                          case HomeBodyState.Review:
                            return ElevatedButton(
                              onPressed:
                                  controller.onShowTomorrowOverViewPressed,
                              child: Text('Conferir dia de amanha'),
                            );
                          case HomeBodyState.OtherDayOverview:
                            return ElevatedButton(
                              onPressed: controller.backToTodayPressed,
                              child: Text('Ver hoje'),
                            );
                          case HomeBodyState.Loading:
                            return Container();
                          case HomeBodyState.Meals:
                            return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        minimumSize:
                                            MaterialStateProperty.resolveWith(
                                                (states) => Size(120, 36)),
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) => Colors.red)),
                                    onPressed: controller.onSkippedPressed,
                                    child: Text('Pulei'),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        minimumSize:
                                            MaterialStateProperty.resolveWith(
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
                  ),),
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
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ],
    );
  }
}
