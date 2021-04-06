import 'package:flutter/material.dart';
import 'package:nutri/app/pages/home/components/food_banner_card_widget.dart';
import 'package:nutri/app/pages/home/components/main_food_selector_widget.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';

class MenuView extends StatelessWidget {
  final List<MenuModel> menuList;
  final PageController pageController;
  final Function(int) onPageChanged;

  MenuView({
    required this.menuList,
    required this.pageController,
    required this.onPageChanged,
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
               FoodBannerCardWidget(
                 ratio: 2.2,
                  image: menuList[idx].img,
                  type: menuList[idx].mealTypeToString(),
                  title: menuList[idx].title,
                ),
              MainFoodSelectorWidget(
                foodList: menuList[idx].mainFoodList,
              ),
              ExtraFoodSelectorWidget(
                extraList: menuList[idx].extraFoodList,
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
