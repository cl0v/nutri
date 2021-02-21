import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';

class ExtraSelectableCard extends StatelessWidget {
  final FoodModel extra;
  final int index;
  final VoidCallback onTap;

  ExtraSelectableCard({Key key, this.extra, this.index, this.onTap});
  final controller = Get.find<HomeController>();
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
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: controller.getSelectedIndex(index)
                    ? Colors.green.withOpacity(.4)
                    : Colors.black.withOpacity(.3) //Trocar a cor
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
                Text(
                  '1', //TODO: Trocar isso
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'unidades', //TODO:Trocar isso
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
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
