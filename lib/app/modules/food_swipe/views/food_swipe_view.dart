import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nutri/app/modules/food_swipe/views/food_swipe_body.dart';

import '../controllers/food_swipe_controller.dart';

class FoodSwipeView extends GetView<FoodSwipeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          FlatButton(
            onPressed: controller.onSkipPressed,
            child: Text('Pular'),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: BlurBgImgCarroussel(),
    );
  }
}
