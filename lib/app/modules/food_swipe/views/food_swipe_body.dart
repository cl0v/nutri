import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nutri/app/modules/food_swipe/components/food_swipe_card.dart';
import 'package:nutri/app/modules/food_swipe/controllers/food_swipe_controller.dart';

//TODO: IDEIA: Pintar de verde o fundo para itens selecionados da mesma forma do extraCard
//TODO:IDEIA: Tornar o foodSwipe um carroussel, para rodar pras duas direçoes
// Alem de deixar o visual mais bonito, ja que tem uma parte escura no lado esquerdo

class BlurBgImgCarroussel extends GetView<FoodSwipeController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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

        SafeArea(
          child: Obx(
            () => controller.isOkey
                ? Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              '${controller.showingFoodSwipeModel.category} (${controller.amountSelected}/${controller.showingFoodSwipeModel.amount})',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 6,
                          child: Center(
                            child: Container(
                              height: width * 1.16,
                              child: PageView.builder(
                                  controller: controller.pageController,
                                  itemCount: controller
                                      .showingFoodSwipeModel.foods.length,
                                  itemBuilder: (context, index) => Obx(
                                        () => FoodSwipeCard(
                                          food: controller.showingFoodSwipeModel
                                              .foods[index],
                                          isChecked:
                                              controller.isChecked(index),
                                          onCheckTapped: () =>
                                              controller.onCheckTapped(
                                            controller.showingFoodSwipeModel
                                                .foods[index],
                                            index,
                                          ),
                                        ),
                                      )),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: RaisedButton(
                              onPressed: controller.onConfirmPressed,
                              child: Text(
                                'Confirmar',
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Container(),
          ),
        ),
        Obx(
          () => !controller.isOkey
              ? GestureDetector(
                  onTap: controller.onBuildCardapioPressed,
                  behavior: HitTestBehavior.translucent,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 250,
                          child: Text(
                            'Vamos montar o cardápio da semana!',
                            style: TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          'Toque aqui',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ),
      ],
    );
  }
}
