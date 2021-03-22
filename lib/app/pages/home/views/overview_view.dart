import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/home/components/meal_card_widget.dart';
import 'package:nutri/app/pages/home/models/overview_model.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({required this.items});

  final List<OverviewModel> items;

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
            child: MealCardWidget(
              image: items[idx - 1].img,
              title: MealModelHelper.getTranslatedMeal(items[idx - 1].meal),
            ),
          );
        },
      ),
    );
  }
}
