import 'package:flutter/material.dart';
import 'package:nutri/app/data/model/food_model.dart';

class FoodCard extends StatelessWidget {
  final FoodModel food;

  const FoodCard({
    required this.food,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(food.img),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
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
                    borderRadius: BorderRadius.circular( 15
                      // bottomLeft: Radius.circular(15),
                      // bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    '${food.title}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Align(
//   child: DotsIndicator(),
//   alignment: Alignment.centerRight,
// ),
// Trabalhar nos dots
class DotsIndicator extends StatelessWidget {
  DotsIndicator();

  Widget _buildDot(int index) {
    return Container(
      height: 12.0,
      margin: EdgeInsets.only(right: 16),
      child: Material(
        color: Colors.white,
        type: MaterialType.circle,
        child: Container(
          width: 8,
          height: 8,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(3, _buildDot),
    );
  }
}
