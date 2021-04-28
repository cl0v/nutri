import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nutri/app/models/food_model.dart';
import 'package:nutri/app/pages/adm/food_list/add_food/add_food_view.dart';
import 'package:path_provider/path_provider.dart';

class FoodListController extends GetxController {
  RxList<FoodModel> foodList = <FoodModel>[].obs;
  final firestore = FirebaseFirestore.instance.collection('foods');
  final storage = FirebaseStorage.instance.ref().child('foods/');

  late Directory appDocDir;
  // FirestoreMealRepository mealRepository = FirestoreMealRepository();

  @override
  void onReady() async {
    super.onReady();
    appDocDir = await getApplicationDocumentsDirectory();
    foodList.assignAll(await loadFoodList());
  }

  onAddFoodPressed(context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddFoodView(),
      ),
    );
  }

  Future<List> _loadJson() async =>
      jsonDecode(await rootBundle.loadString('assets/jsons/food_data.json'));

  Future<List<FoodModel>> loadFoodList() async => (await _loadJson())
      // .where((map) =>
      //     map['category'] == FoodModel.getIndexFromCategory(category))
      .map((map) => FoodModel.fromMap(map))
      .toList();
}
