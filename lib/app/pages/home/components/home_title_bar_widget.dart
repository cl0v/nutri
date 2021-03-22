import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/home/controllers/home_controller.dart';

class HomeTitleBarWidget extends StatelessWidget {
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() => IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: controller.previewBtnDisabled!
                  ? null
                  : controller.onPreviewDayPressed,
            )),
        Obx(() => Text(controller.title ?? 'Carregando titulo')),
        Obx(() => IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: controller.nextBtnDisabled!
                  ? null
                  : controller.onNextDayPressed,
            )),
      ],
    );
  }
}
