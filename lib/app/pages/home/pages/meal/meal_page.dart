import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/home/pages/meal/components/main_food_selector_widget.dart';

import 'meal_controller.dart';

class MealPage extends GetView<MealController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            controller.dietModel.meal.mealTypeToString().toUpperCase()),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 2.5,
              child: Container(
                margin: EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(controller.dietModel.meal.img),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            MainFoodSelectorWidget(
              foodList: controller.dietModel.mainFoodList!,
            ),
            ExtraFoodSelectorWidget(
              extraList: controller.dietModel.extraFoodList!,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.resolveWith(
                          (states) => Size(120, 36)),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.red)),
                  onPressed: controller.onSkipPressed,
                  child: Text('Pulei'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.resolveWith(
                          (states) => Size(120, 36)),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.green)),
                  onPressed: controller.onDonePressed,
                  child: Text('Concluí'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
