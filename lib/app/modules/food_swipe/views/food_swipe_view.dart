import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nutri/app/modules/food_swipe/views/food_swipe_body.dart';

import '../controllers/food_swipe_controller.dart';

class FoodSwipeView extends GetView<FoodSwipeController> {
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          extendBodyBehindAppBar: true,
          body: FoodSwipeBody(),
        ),
      ],
    );
  }
}
