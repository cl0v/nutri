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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    food.desc,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Center(
                    child:  IconButton(
                        icon: Icon(Icons.check_circle),
                        color: !isChecked ? Colors.white : Colors.greenAccent,
                        iconSize: 64,
                        onPressed: onCheckTapped,
                      ),
                      // child: ratingBtns(),
                    ),
                  
                  Text(
                    '*Por favor marque o quanto você gostaria que esse alimento estivesse em seu cardápio.',
                    style: TextStyle(color: Colors.white, fontSize: 8),
                    textAlign: TextAlign.center,
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
        child: Center(
          child: Text('Info : Texto nessa pagina'),
        ),
      ),
    );
  }
}
