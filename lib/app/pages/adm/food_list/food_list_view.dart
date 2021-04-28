import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/adm/food_list/food_list_controller.dart';

class FoodListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put<FoodListController>(FoodListController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed:() => controller!.onAddFoodPressed(context),
        child: Icon(Icons.add),
      ),
      body: Obx(
        () => controller!.foodList.length > 0
            ? ListView.builder(
                itemCount: controller.foodList.length,
                itemBuilder: (ctx, idx) {
                  var food = controller.foodList[idx];
                  return ListTile(
                    title: Text(food.title),
                    leading: Image.asset(food.img),
                  );
                })
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
