import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/home/components/food_selectable_card.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';

// Mostrar as comidas selecionadas de forma a ir aparecendo uma por uma
// se apenas uma for selecionada, ela ocupa todo o espaço
// caso duas sejam selecionadas, ocupar metade do espaço

//TODO: O que fazer quando nenhum acompanhamento for selecionado?

class ExtraFoodSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final controller = Get.find<HomeController>();
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 2.6,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Obx(
              () => controller.extraFoodsAvailable.isNotEmpty
                  ? ListView(
                      itemExtent: width / 3,
                      scrollDirection: Axis.horizontal,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                          child: Obx(() => Image.asset(
                                controller
                                    .extraFoodsAvailable[(controller
                                                .selectedExtrasList
                                                .isNotEmpty &&
                                            controller
                                                    .selectedExtrasList.length >
                                                0)
                                        ? controller.selectedExtrasList[0]
                                        : 0]
                                    .img,
                                fit: BoxFit.cover,
                              )),
                        ),
                        Image.asset(
                          controller
                              .extraFoodsAvailable[(controller
                                          .selectedExtrasList.isNotEmpty &&
                                      controller.selectedExtrasList.length > 1)
                                  ? controller.selectedExtrasList[1]
                                  : 1]
                              .img,
                          fit: BoxFit.cover,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          child: Image.asset(
                            controller
                                .extraFoodsAvailable[(controller
                                            .selectedExtrasList.isNotEmpty &&
                                        controller.selectedExtrasList.length >
                                            2)
                                    //BUG: Pode ter duas imagens iguais
                                    ? controller.selectedExtrasList[2]
                                    : 2]
                                .img,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    )
                  : Container(),
            ),
          ),
        ),
        Center(
          child: Obx(
            () => Text(
              'Selecione até 3 acompanhamentos (${controller.selectedExtrasList.length}/3)',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        AspectRatio(
          aspectRatio: 5,
          child: Obx(
            () => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemExtent: width / 3.8,
              itemCount: controller.extraFoodsAvailable.length,
              itemBuilder: (context, idx) => FoodSelectableCard(
                food: controller.extraFoodsAvailable[idx],
                onTap: () => controller.onExtraTapped(idx),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
