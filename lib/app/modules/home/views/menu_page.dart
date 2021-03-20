import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nutri/app/modules/home/components/extra_food_selector.dart';
import 'package:nutri/app/modules/home/components/food_card.dart';
import 'package:nutri/app/modules/home/components/main_food_selector.dart';
import 'package:nutri/app/modules/home/models/meal_model.dart';
import 'package:nutri/app/modules/home/models/menu_model.dart';

class MenuPage extends StatelessWidget {
  final List<MenuModel> menuList;
  final List<OverviewModel> mealModel;
  final PageController pageController;
  final Function(int) onPageChanged;
  final Function(int) onMainFoodTapped;
  final Function(int) onExtraFoodTapped;

  MenuPage({
    required this.menuList,
    required this.mealModel,
    required this.pageController,
    required this.onPageChanged,
    required this.onMainFoodTapped,
    required this.onExtraFoodTapped,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: onPageChanged,
      itemBuilder: (c, idx) => SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 2.2,
                child: FoodCard(
                  image: mealModel[idx].img,
                  title: MealModelHelper.getTranslatedMeal(mealModel[idx].meal),
                ),
              ),
              FoodSelector(
                foodList: menuList[idx].mainFoodList,
                onTap: onMainFoodTapped,
              ),
              // menuList[idx].extraList.isNotEmpty ? Divider() : Container(),
              // menuList[idx].extraList.isNotEmpty ?FoodSelector(
              //   foodList: menuList[idx].extraList,
              //   onTap: onExtraFoodTapped,
              // )
              // menuList[idx].extraList.isNotEmpty
              //     ? ExtraFoodSelector() // Permitir multipla escolha
                  // : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
