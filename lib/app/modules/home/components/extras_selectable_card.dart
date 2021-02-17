import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/model/extras_model.dart';
import 'package:nutri/app/modules/home/controllers/home_controller.dart';

class ExtrasSelectableCard extends StatelessWidget {
  final ExtraModel extra;
  final int index;
  final VoidCallback onTap;

  ExtrasSelectableCard({Key key, this.extra, this.index, this.onTap});
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap
      //TODO: Trocar a cor do item para verde com opacidade
      ,
      child: Container(
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(
              //TODO: Trocar para assets
              extra.food.img,
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
                // Center(
                //   child:
                Text(
                  extra.food.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  extra.amount.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  extra.unidade,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
