import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/modules/home/components/meal_card.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';

class HomeBody extends StatelessWidget {
  final HomeController controller;
  const HomeBody({
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders =
        controller.foodList.map((food) => MealCard(food: food)).toList();

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
        child: Container(
            child: Column(
          children: <Widget>[
            Text(
              'Comer hoje:',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
            CarouselSlider(
              options: CarouselOptions(
                // autoPlay: true,
                aspectRatio: 1.6,
                scrollDirection: Axis.vertical,
                viewportFraction: 0.85,
                enlargeCenterPage: true,
              ),
              items: imageSliders,
            ),
            
            Divider(),
            Text(
              'Comer amanhã:',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
            CarouselSlider(
              options: CarouselOptions(
                // autoPlay: true,
                // aspectRatio: 2.0,

                enlargeCenterPage: true,
              ),
              items: imageSliders,
            ),
          ],
        )),
      ),
    ]);
  }
}
