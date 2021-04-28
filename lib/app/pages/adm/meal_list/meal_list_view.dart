import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'meal_list_controller.dart';

class MealListView extends StatelessWidget {
  final controller = Get.put<MealListController>(MealListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: controller!.onAddMealPressed,
        child: Icon(
          Icons.add,
        ),
      ),
      body: Obx(
        () => controller!.mealList.length > 0
            ? ListView.builder(
                itemCount: controller!.mealList.length,
                itemBuilder: (ctx, idx) {
                  var meal = controller!.mealList[idx];
                  return ListTile(
                    title: Text(meal.title),
                    leading: Image.network(meal.img),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => controller!.onDeleteMealPressed(meal),
                    ),
                  );
                })
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
