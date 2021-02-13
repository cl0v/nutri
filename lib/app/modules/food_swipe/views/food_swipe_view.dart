import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nutri/app/modules/food_swipe/views/body.dart';

import '../controllers/food_swipe_controller.dart';

class FoodSwipeView extends GetView<FoodSwipeController> {
  @override
  Widget build(BuildContext context) {
    return BlurBgImgCarroussel();
  }
}
