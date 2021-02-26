import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';

import 'package:nutri/app/modules/home/views/home_body.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Obx(
          () => Row(
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

        // TODO: Botao que vai para a checklist ???
        // TODO: Pagina de FAQ
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.help),
        //     onPressed: () {
        // TODO: implement FAQ PAGE
        //     },
        //   )
        // ],
      ),
      body: HomeBody(),
    );
  }
}
