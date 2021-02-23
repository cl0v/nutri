import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/home/components/extras_selectable_card.dart';
import 'package:nutri/app/modules/home/components/meal_card.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';

class HomeBody extends GetView<HomeController> {
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
        SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Obx(
                  () => AspectRatio(
                    aspectRatio: 16 / 9,
                    child: PageView.builder(
                      onPageChanged: controller.onPageChanged,
                      itemCount: controller.mealListLenght.value,
                      controller: controller.pageController,
                      physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => MealCard(
                          mealCardModel: controller.mealList[index],
                          mealCardState:
                              controller.mealList[index].mealCardState,
                          onConfirmedPressed: () =>
                              controller.onDonePressed(index),
                          onSkippedPressed: () =>
                              controller.onSkipPressed(index),
                          onChangePressed: controller.onChangePressed,
                        
                      ),
                    ),
                  ),
                ),
                Obx(() => Text(
                      'Selecione ${controller.extrasAmount} acompanhamentos',
                      style: TextStyle(color: Colors.white),
                    )),
                Obx(
                  () => GridView.builder(
                    itemCount: controller.extras.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return Obx(
                        () => ExtraSelectableCard(
                          extra: controller.extras[index],
                          onTap: () => controller.onExtraTapped(index),
                          isSelected: controller.getSelectedIndex(index),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container cardbebaagua() {
    return Container(
      height: 90,
      width: 90,
      margin: EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(
                'assets/images/foods/agua.jpg',
              ), //Trocar por ASSETIMAGE
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 4,
                  right: 4,
                  bottom: 0,
                  top: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Beba água',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
