import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/modules/home/components/meal_card.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';

class HomeBody extends StatelessWidget {
  final HomeController controller;
  const HomeBody({
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = controller.foodList
        .map(
          (food) => MealCard(
            food: food,
            onConfirmedPressed: controller.onDonePressed,
          ),
        )
        .toList();

    return Stack(children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        child: Image.asset(
          'assets/Profile.jpg',
          fit: BoxFit.cover,
        ),
      ),
      SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only( top: 16),
              child: Text(
                'O que comer hoje',
                style:
                    Get.theme.textTheme.headline5.copyWith(color: Colors.white),
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                // autoPlay: true,
                aspectRatio: 1.6,
                scrollDirection: Axis.vertical,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
              ),
              carouselController: controller.c,
              items: imageSliders,
            ),
            Divider(),
            Container(
              height: 180,
              margin: EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/foods/agua.jpg'), //Trocar por ASSETIMAGE
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
            ),
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
    ]);
  }
}
