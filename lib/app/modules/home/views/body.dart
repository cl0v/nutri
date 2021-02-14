import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nutri/app/data/model/food_model.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key key,
  }) : super(key: key);

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
                // aspectRatio: 2.0,

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

List<FoodModel> foodList = [
  FoodModel(
    imgUrl:
        'https://i.pinimg.com/474x/e2/fe/5c/e2fe5c199feb50e474ce4f2c98c5274b.jpg',
    text: 'Café da manhã',
    title: 'Café preto',
  ),
  FoodModel(
    imgUrl:
        'https://i.pinimg.com/564x/e0/d1/08/e0d108f2b18bc168edc824bfab8399a2.jpg',
    text: 'Almoço',
    title: 'Peito de frango',
  ),
  FoodModel(
    imgUrl:
        'https://i.pinimg.com/474x/de/58/f7/de58f749a33fb02aca97492b35e73382.jpg',
    text: 'Jantar',
    title: 'Carne com brocolis',
  ),
];

final List<Widget> imageSliders =
    foodList.map((food) => FoodCard(food: food)).toList();

class FoodCard extends StatelessWidget {
  final food;

  const FoodCard({Key key, this.food}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(food.imgUrl, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  child: IconButton(
                    icon: Icon(
                      Icons.info,
                      size: 32,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      print('tapado');
                    },
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      '${food.text} : ${food.title}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
