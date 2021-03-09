import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nutri/app/modules/food_swipe/components/food_swipe_card.dart';
import 'package:nutri/app/modules/food_swipe/controllers/food_swipe_controller.dart';

//IDEIA: Tornar o foodSwipe um carroussel, para rodar pras duas direçoes
//IDEIA: Alem de deixar o visual mais bonito, ja que tem uma parte escura no lado esquerdo
//IDEIA: Caso a pessoa não queria nenhum, deixar um card no final para adicionar outro alimento ou um card que quando marcado ele fala que não quer nenhum daqueles
//Um cardzao cinza com uma lupa no centro por exemplo
//FIXME: A forma de selecionar as comidas nao está intuitivo o suficiente
class FoodSwipeBody extends GetView<FoodSwipeController> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
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
                              '${controller.currentFoodSwipeModel.category} (${controller.amountSelected}/${controller.currentFoodSwipeModel.maximum})',
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
                                // pageSnapping: false,
                                itemCount: controller
                                    .currentFoodSwipeModel.foods.length,
                                itemBuilder: (context, index) => Obx(
                                  () => FoodSwipeCard(
                                    food: controller
                                        .currentFoodSwipeModel.foods[index],
                                    isChecked: controller.isChecked(index),
                                    onCheckTapped: () =>
                                        controller.onCheckTapped(
                                      controller
                                          .currentFoodSwipeModel.foods[index],
                                      index,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Obx(
                              () => ElevatedButton(
                                onPressed: controller.isConfirmBtnAvailable
                                    ? controller.onConfirmPressed
                                    : null,
                                child: Text(
                                  'Confirmar',
                                ),
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
