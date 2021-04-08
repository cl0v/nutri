import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/home/components/food_banner_card_widget.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/home_meal_model.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({required this.items});

  final List<HomeMealModel> items;

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
          return  FoodBannerCardWidget(
              image: items[idx - 1].img,
              title: items[idx - 1].title,
              type: items[idx - 1].mealTypeToString(),
          );
        },
      ),
    );
  }
}
