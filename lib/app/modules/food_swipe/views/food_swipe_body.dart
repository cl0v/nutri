import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:nutri/app/modules/food_swipe/components/food_rating_card.dart';
import 'package:nutri/app/modules/food_swipe/controllers/food_swipe_controller.dart';

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
        //TODO: Texto selecione até 7 dessas(Calcular quantos deverei escolher)
        //Criar model que tratará essas decisoes (quantidade, que alimentos sugerir com base nas questions, etc);
        //TODO: Remover as carinhas e colocar um ou dois botoes de sim ou nao para a semana
        //Ou uma caixinha de selecao grande que quando marcado será de alguma forma mostrado para o usuario
        //Ou Pintar de verde o fundo para itens selecionados da mesma forma do extraCard
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Center(
                child: Text('Escolha até 7 alimentos', style: TextStyle(color: Colors.white, fontSize: 28),),
              ), flex: 1,),
              Expanded(
                flex: 6,
                child: Obx(
                  () => controller.isOkey
                      ? Center(
                          child: Container(
                            height: width * 1.16,
                            child: PageView.builder(
                              // pageSnapping: false,
                                controller: controller.pageController,
                                itemCount: controller.foodList.length,
                                itemBuilder: (context, index) => Obx(
                                      () => FoodRatingCard(
                                        food: controller.foodList[index],
                                        isChecked: controller.isChecked(index),
                                        onCheckTapped: () =>
                                            controller.onCheckTapped(
                                                controller.foodList[index], index),
                                      ),
                                    )),
                          ),
                        )
                      : Container(),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Obx(
                    () => controller.isOkey
                        ?  RaisedButton(
                                onPressed: () {},
                                child: Text(
                                  'Confirmar',
                                ),
                          )
                        : Container(),
                  ),
                ),
              ),
            ],
          ),
        ),

        //TODO: Em um celular que a tela é menor, pode dar bizu
        Obx(
          () => !controller.isOkey
              ? GestureDetector(
                  onTap: controller.onBuildCardapioPressed,
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
