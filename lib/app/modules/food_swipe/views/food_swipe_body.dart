import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nutri/app/modules/food_swipe/components/food_card.dart';
import 'package:nutri/app/modules/food_swipe/controllers/food_swipe_controller.dart';

class BlurBgImgCarroussel extends GetView<FoodSwipeController> {
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
        Center(
          child: Obx(
            () => Container(
              height: 450,
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.foodList.length,
                itemBuilder: (context, index) => FoodCard(
                  converter: controller.getPreparoFormated,
                  index: index,
                  food: controller.foodList[index],
                  onRatingTapped: controller.onRatingTapped,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
