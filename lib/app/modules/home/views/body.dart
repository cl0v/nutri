import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/home/components/extras_selectable_card.dart';
import 'package:nutri/app/modules/home/components/meal_card.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';

class HomeBody extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
                () => CarouselSlider(
                  options: CarouselOptions(
                    // autoPlay: true,
                    aspectRatio: 1.7,
                    scrollDirection: Axis.vertical,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                  ),
                  //TODO: Dar um jeito de saber quando o carrousel vai trocar
                  carouselController: controller.carouselController,
                  items: controller.mealList
                      .map(
                        (meal) => MealCard(
                          meal: meal,
                          onConfirmedPressed:()=> controller.onDonePressed(meal),
                        ),
                      )
                      .toList(),
                ),
              ),
              Text(
                'Selecione 3 acompanhamentos',
                style: TextStyle(color: Colors.white),
              ),
              Obx(
                () => GridView.builder(
                  itemCount: controller.extraList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return ExtraSelectableCard(
                      extra: controller.extraList[index],
                      onTap: () => controller.onExtraTapped(index),
                      index: index,
                    );
                  },
                ),
              ),
              //TODO: Descomentar daqui pra cima para ativar os card de extra

//TODO: Criar parte de card de ingredientes secundarios
//Tocar para marcar quais acompanhamentos serão usados
//Criar Card de figurinhas 3*3 de beba agua, tocar em cada uma para marcar (Provavelmente em uma pagina separada)
              // Text(
              //   'Comer amanhã:',
              //   style: TextStyle(fontSize: 32, color: Colors.white),
              // ),
              // CarouselSlider(
              //   options: CarouselOptions(
              //     // autoPlay: true,
              //     // aspectRatio: 2.0,

              //     enlargeCenterPage: true,
              //   ),
              //   items: imageSliders,
              // ),
            ],
          ),
        ),
      ),
    ]);
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
                //TODO: Adicionar botao de informacoes Icon.info
                //TODO: Modificar os botoes concluido e 'passei'
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
