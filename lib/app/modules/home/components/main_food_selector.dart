import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/home/components/food_card.dart';
import 'package:nutri/app/modules/home/components/food_selectable_card.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';

//Distribuir de maneira centralizada as opçoes de escolha
// Quando escolher, esconde as opçoes e aparece uma pequena seta para expandir

//FIXME: Não está intuitivo o suficiente que é para tocar em alguma das comidas

//TODO: Se tiver mais de uma opção, mostrar as opções e um texto falando, selecione uma opção
// Se tiver apenas uma opção, nao mostrar o texto
// Se tiver uma opção, ja mostrar escondido as opçes
class MainFoodSelector extends StatelessWidget {
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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

        //TODO: Quando seleciona ele esconde, e vira uma setinha que quando clica ele expande novamente
        AspectRatio(
          aspectRatio: 5,
          child: Obx(
            () => controller.mainFoodsAvailable.isNotEmpty
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
