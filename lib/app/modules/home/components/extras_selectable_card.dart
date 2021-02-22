import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nutri/app/data/model/food_model.dart';

class ExtraSelectableCard extends StatelessWidget {
  final bool isSelected;
  final FoodModel extra;
  final VoidCallback onTap;

  ExtraSelectableCard({Key key, this.extra, this.onTap, this.isSelected});

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
              extra.img,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: isSelected
                ? Colors.green.withOpacity(.4)
                : Colors.black.withOpacity(.3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                extra.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              // Text(
              //   '1',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 18,
              //   ),
              // ),
              // Text(
              //   'unidades', 
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 12,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
