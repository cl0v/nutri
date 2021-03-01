import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/home/components/food_card.dart';
import 'package:nutri/app/modules/home/components/food_selectable_card.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';

//BUG: Corrigir o espaço branco do café

class HomeBody extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      itemBuilder: (c, idx) => SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Obx(() => Text(
                    '${controller.mealCategory}',
                    style:
                        Get.textTheme.headline5.copyWith(color: Colors.white),
                  )),
              //TODO: Categoria do meal
              MainFoodSelector(),
              Divider(),
              Obx(
                () => (controller.mainFoodsAvailable.isNotEmpty &&
                        controller.mealIndex != 0)
                    ? ExtraFoodSelector()
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
                                                controller.selectedExtrasList
                                                        .length >
                                                    0 &&
                                                controller.selectedExtrasList !=
                                                    null)
                                            ? controller.selectedExtrasList[0]
                                            : 0]
                                        .img ??
                                    '',
                                fit: BoxFit.cover,
                              )),
                        ),
                        Image.asset(
                          controller
                                  .extraFoodsAvailable[(controller
                                              .selectedExtrasList.isNotEmpty &&
                                          controller.selectedExtrasList.length >
                                              1 &&
                                          controller.selectedExtrasList != null)
                                      ? controller.selectedExtrasList[1]
                                      : 1]
                                  .img ??
                              '',
                          fit: BoxFit.cover,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          child: Image.asset(
                            controller
                                    .extraFoodsAvailable[(controller
                                                .selectedExtrasList
                                                .isNotEmpty &&
                                            controller
                                                    .selectedExtrasList.length >
                                                2 &&
                                            controller.selectedExtrasList !=
                                                null) //BUG: Corrigir bug que ele libera o estado e pode ter dois do mesmo
                                        ? controller.selectedExtrasList[2]
                                        : 2]
                                    .img ??
                                '',
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
          child: Text(
            'Acompanhamentos (0/3)',
            style: TextStyle(color: Colors.white),
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
        )
      ],
    );
  }
}

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
                    food: controller
                        .mainFoodsAvailable[controller.selectedFoodIdx.value],
                  )
                : Container(),
          ),
        ),

        //TODO: Quando seleciona ele esconde, e vira uma setinha que quando clica ele expande novamente
        AspectRatio(
          aspectRatio: 5,
          child: Obx(
            () => controller.mainFoodsAvailable.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemExtent: width / 3,
                    itemCount: controller.mainFoodsAvailable.length,
                    itemBuilder: (context, idx) => Obx(
                      () => MainFoodSelectableCard(
                        food: controller.mainFoodsAvailable[idx],
                        onTap: () => controller.onMainFoodTapped(idx),
                        selected: controller.isMainFoodSelected(idx),
                      ),
                    ),
                  )
                : Container(),
          ),
        )
      ],
    );
  }
}
