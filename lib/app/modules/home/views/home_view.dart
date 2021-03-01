import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';

import 'package:nutri/app/modules/home/views/home_body.dart';
import 'package:nutri/constants.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            'assets/Profile.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, bottom: 12),
              child: Row(
                children: [
                  ButtonTheme(
                    buttonColor: kRedColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    child: Expanded(
                      child: RaisedButton(
                        onPressed: controller.onSkippedPressed,
                        child: Text('Pulei'),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    buttonColor: kGreenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Expanded(
                      child: RaisedButton(
                        onPressed: controller.onDonePressed,
                        child: Text('Concluí'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: controller.isPreviewBtnDisabled.value
                        ? null
                        : controller.onPreviewDayPressed,
                  ),
                  Text(controller.getDayTitle()),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: controller.isNextBtnDisabled.value
                        ? null
                        : controller.onNextDayPressed,
                  ),
                ],
              ),
            ),

          ),
          body: HomeBody(),
        ),
      ],
    );
  }
}
