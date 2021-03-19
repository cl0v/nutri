import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealCard extends StatelessWidget {
  final String image;
  final String title;

  const MealCard({
    required this.image,
    required this.title,
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
              image: AssetImage(image),
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
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Get.theme!.textTheme.headline6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
