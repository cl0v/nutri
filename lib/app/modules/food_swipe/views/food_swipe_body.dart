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
        //TODO: Apos confirmar, Agora selecione alguns vegetais para acompanhamento(onde vou incluir ovos mds????)
        //TODO: Apos confirmar, agora escolha uma bebida que te agrada no cafe da manha (somente com adoçante e sem acompanhamento PURO)
        //Criar model que tratará essas decisoes (quantidade, que alimentos sugerir com base nas questions, etc);
        //TODO: Remover as carinhas e colocar um ou dois botoes de sim ou nao para a semana
        //Ou uma caixinha de selecao grande que quando marcado será de alguma forma mostrado para o usuario
        //Ou Pintar de verde o fundo para itens selecionados da mesma forma do extraCard
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
                              controller.showingFoodSwipeModel.category,
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
                              height: width *
                                  1.16, //TODO: Possivelmente adicionar um carroussel, para rodar pras duas direçoes
                              // Alem de deixar o visual mais bonito, ja que tem uma parte escura no lado esquerdo
                              child: PageView.builder(
                                  controller: controller.pageController,
                                  itemCount: controller
                                      .showingFoodSwipeModel.foods.length,
                                  itemBuilder: (context, index) => Obx(
                                        () => FoodRatingCard(
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
                              //TODO: Modificar esse botao
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

        //TODO: Em um celular que a tela é menor, pode dar bizu
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
