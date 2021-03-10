import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/home/components/food_card.dart';
import 'package:nutri/app/modules/home/components/food_selectable_card.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';

// Quando escolher, esconde as opçoes e aparece uma pequena seta para expandir
//IDEIA: Quando seleciona ele esconde, e vira uma setinha que quando clica ele expande novamente

//FIXME: Não está intuitivo o suficiente que é para tocar em alguma das comidas

class MainFoodSelector extends StatelessWidget {
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 2.2,
          child: Obx(
            () => controller.mainFoodsAvailable.isNotEmpty
                ? FoodCard(
                    food: controller.mainFoodsAvailable[
                        controller.selectedMainFoodIdx.value],
                  )
                : Container(),
          ),
        ),
        Obx(
          () => controller.mainFoodsAvailable.length > 1
              ? Text(
                  'Selecione uma opção',
                  style: TextStyle(color: Colors.white),
                )
              : Container(),
        ),
        AspectRatio(
          aspectRatio: 5,
          child: Obx(
            () => controller.mainFoodsAvailable.isNotEmpty &&
                    controller.mainFoodsAvailable.length > 1
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: controller.mainFoodsAvailable.map((food) {
                      var idx = controller.mainFoodsAvailable.indexOf(food);
                      return Expanded(
                        child: MainFoodSelectableCard(
                          food: food,
                          onTap: () => controller.onMainFoodTapped(idx),
                          selected: controller.isMainFoodSelected(idx),
                        ),
                      );
                    }).toList())

                // ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemExtent: width / 3,
                //     itemCount: controller.mainFoodsAvailable.length,
                //     itemBuilder: (context, idx) => Obx(
                //       () => MainFoodSelectableCard(
                //         food: controller.mainFoodsAvailable[idx],
                //         onTap: () => controller.onMainFoodTapped(idx),
                //         selected: controller.isMainFoodSelected(idx),
                //       ),
                //     ),
                //   )
                : Container(),
          ),
        )
      ],
    );
  }
}
