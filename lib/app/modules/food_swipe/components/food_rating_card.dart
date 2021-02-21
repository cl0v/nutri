import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/constants.dart';

// GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

class FoodRatingCard extends StatelessWidget {
  final FoodModel food;
  final bool isChecked;
  final VoidCallback onCheckTapped;

  const FoodRatingCard({
    this.food,
    this.isChecked = false,
    @required this.onCheckTapped,
  });

  //TODO: Diminuir o espaço preto acima do titulo
  //TODO: Trocar de lugar e mudar o estilo da fonte da informaçao para tocar na imagem pra ver desc
  //TODO: Modificar o botao para melhorar o visual
  //TODO: Melhorar o aviso na parte inferior

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      flipOnTouch: true,
      front: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(food.img),
            fit: BoxFit.cover,
          ),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          // vertical: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    food.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Toque na imagem para ver a descrição',
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  ),
                  IconButton(
                    icon: Icon(Icons.check_circle),
                    color: !isChecked ? Colors.white : Colors.greenAccent,
                    iconSize: 64,
                    onPressed: onCheckTapped,
                  ),

                  Text(
                    '*Por favor marque o quanto você gostaria que esse alimento estivesse em seu cardápio.',
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      back: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(food.desc, textAlign: TextAlign.center,),
          ),
      ),
    );
  }
}
