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
        
        Obx(
          () => controller.isOkey
              ? Center(
                  child: Obx(
                    () => Container(
                      height: (width/3)*3.5,
                      child: PageView.builder(
                        controller: controller.pageController,
                        itemCount: controller.foodList.length,
                        itemBuilder: (context, index) => FoodRatingCard(
                          food: controller.foodList[index],
                          onRatingTapped: controller.onRatingTapped,
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
        ),

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
