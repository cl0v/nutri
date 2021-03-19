//TODO: Implement reviewPage


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/home/components/food_card.dart';
import 'package:nutri/app/modules/home/models/meal_card_model.dart';
import 'package:nutri/constants.dart';

class ReviewPage extends StatelessWidget {
  final List<Map<String, String>> items;

  const ReviewPage({required this.items});

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
            child: FoodCard(
              image: items[idx - 1]['image']!,
              title: items[idx - 1]['title']!,
              color: items[idx - 1]['color']! == MealCardState.Done.toString()
                  ? kGreenColor.withOpacity(.4)
                  : kErrorColor.withOpacity(.4),
            ),
          );
        },
      ),
    );
  }
}
