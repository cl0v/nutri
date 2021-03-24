//TODO: Implement reviewPage

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/home/components/food_banner_card_widget.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';
import 'package:nutri/constants.dart';

class ReviewView extends StatelessWidget {
  final List<ReviewModel> items;

  const ReviewView({required this.items});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: items.length + 1,
        itemBuilder: (ct, idx) {
          if (idx == 0)
            return Text(
              'Revisão do dia:',
              style: Get.textTheme!.headline4,
              textAlign: TextAlign.center,
            ); //Refeições do dia
          return AspectRatio(
            aspectRatio: 2.9,
            child: FoodBannerCardWidget(
              image: items[idx - 1].overviewModel.img,
              title: items[idx - 1].overviewModel.mealTypeToString(),
              color: items[idx - 1].done
                  ? kGreenColor.withOpacity(.4)
                  : kErrorColor.withOpacity(.4),
            ),
          );
        },
      ),
    );
  }
}
