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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                'Modificar isso aqui:',
                style: Get.theme.textTheme.headline5.copyWith(color: Colors.white),
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
            Spacer(),
            RaisedButton(
              // padding: EdgeInsets.only(right: 30),
              onPressed: () {},
              child: Container(
                child: Center(
                  child: Text(
                    'Remover esse botao',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                width: double.infinity,
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
