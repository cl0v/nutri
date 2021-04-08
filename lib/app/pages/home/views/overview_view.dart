import 'package:flutter/material.dart';
import 'package:nutri/app/pages/home/components/food_banner_card_widget.dart';
import 'package:nutri/app/pages/home/models/home_meal_model.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({required this.items, required this.onBannerTapped});

  final List<HomeMealModel> items;
  final VoidCallback onBannerTapped;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ct, idx) {
          return FoodBannerCardWidget(
            image: items[idx].img,
            title: items[idx].title,
            type: items[idx].mealTypeToString(),
            onBannerTapped: onBannerTapped,
          );
        },
      ),
    );
  }
}
