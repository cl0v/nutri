import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/main_food_selector_widget.dart';
import 'menu_controller.dart';

class MenuPage extends GetView<MenuController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.mealModel.mealTypeToString().toUpperCase(),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(
        () => controller.menuHack
            ? SafeArea(
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
                                image: AssetImage(controller.menu!.meal.img),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    MainFoodSelectorWidget(
                      foodList: controller.menu!.mainFoodList!,
                    ),
                    Expanded(
                      flex: 2,
                      child: ExtraFoodSelectorWidget(
                        //TODO: Esse cara ta dando overflow
                        extraList: controller.menu!.extraFoodList!,
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
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
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    minimumSize: Size(120, 36),
                  ),
                  onPressed: controller.buttonsEnabled
                      ? controller.onSkipPressed
                      : null,
                  child: Text('Pulei'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    minimumSize: Size(120, 36),
                  ),
                  onPressed: controller.buttonsEnabled
                      ? controller.onDonePressed
                      : null,
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
