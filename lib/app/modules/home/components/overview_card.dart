import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/home/models/meal_model.dart';
import 'package:nutri/app/modules/home/components/food_card.dart';
import 'package:nutri/app/modules/home/components/meal_card.dart';

class OverviewCard extends StatelessWidget {
  const OverviewCard({required this.items});

  final List<MealModel> items;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: items.length + 1,
        itemBuilder: (ct, idx) {
          if (idx == 0)
            return Text(
              'Refeições do dia:',
              style: Get.textTheme!.headline4,
              textAlign: TextAlign.center,
            ); //Refeições do dia
          return AspectRatio(
            aspectRatio: 2.9,
            child: MealCard(
              image: items[idx - 1].img,
              title: MealModelHelper.getTranslatedMeal(items[idx - 1].meal),
            ),
          );
        },
      ),
    );
  }
}
