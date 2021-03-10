import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:nutri/app/data/model/food_model.dart';

//TODO: Deixar o visual mais limpo e mais intuitivo (Botao nao intuitivo / aviso nao está limpo)

class FoodSwipeCard extends StatelessWidget {
  final FoodModel food;
  final bool isChecked;
  final VoidCallback onCheckTapped;

  const FoodSwipeCard({
    this.food,
    this.isChecked = false,
    @required this.onCheckTapped,
  });


  @override
  Widget build(BuildContext context) {
    return FlipCard(
      flipOnTouch: true,
      speed: 250,
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
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.only(
                right: 20,
                left: 20,
                bottom: 25,
                top: 10,
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
                  IconButton(
                    icon: Icon(Icons.check_circle),
                    color: !isChecked ? Colors.white : Colors.greenAccent,
                    iconSize: 52,
                    onPressed: onCheckTapped,
                  ),
                  Text(
                    '*Toque na imagem para ver mais informações*',
                    style: TextStyle(color: Colors.white, fontSize: 8),
                  ),
                  Text(
                    'Por favor marque caso queira que esse alimento esteja em seu cardápio.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      back: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            food.desc,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
