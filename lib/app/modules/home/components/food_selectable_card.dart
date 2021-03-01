import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nutri/app/data/model/food_model.dart';

class FoodSelectableCard extends StatefulWidget {
  final FoodModel food;
  final Function onTap;

  FoodSelectableCard({
    this.food,
    this.onTap,
  });

  @override
  _FoodSelectableCardState createState() => _FoodSelectableCardState();
}

class _FoodSelectableCardState extends State<FoodSelectableCard> {
  bool selectedState = false;

  onTap() {
    if (widget.onTap()) {
      setState(() {
        selectedState = true;
      });
    } else {
      setState(() {
        selectedState = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(
              widget.food.img,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: selectedState
                ? Colors.green.withOpacity(.4)
                : Colors.black.withOpacity(.3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.food.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainFoodSelectableCard extends StatelessWidget {
  final FoodModel food;
  final Function onTap;
  final bool selected;

  MainFoodSelectableCard({
    this.food,
    this.onTap,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(
              food.img,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: selected
                ? Colors.green.withOpacity(.4)
                : Colors.black.withOpacity(.3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                food.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
