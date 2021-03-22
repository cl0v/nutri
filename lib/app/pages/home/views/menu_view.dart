import 'package:flutter/material.dart';
import 'package:nutri/app/pages/home/components/food_card_widget.dart';
import 'package:nutri/app/pages/home/components/food_selector_widget.dart';
import 'package:nutri/app/pages/home/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';

class MenuView extends StatelessWidget {
  final List<MenuModel> menuList;
  final List<OverviewModel> mealModel;
  final PageController pageController;
  final Function(int) onPageChanged;
  final Function(int) onExtraFoodTapped;

  MenuView({
    required this.menuList,
    required this.mealModel,
    required this.pageController,
    required this.onPageChanged,
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
                child: FoodCardWidget(
                  image: mealModel[idx].img,
                  title: MealModelHelper.getTranslatedMeal(mealModel[idx].meal),
                ),
              ),
              FoodSelectorWidget(
                foodList: menuList[idx].mainFoodList,
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
