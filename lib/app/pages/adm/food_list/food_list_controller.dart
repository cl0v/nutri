import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/interfaces/repositories/server_storage_interface.dart';
import 'package:nutri/app/models/food_model.dart';
import 'package:nutri/app/pages/adm/food_list/add_food/add_food_view.dart';
import 'package:nutri/app/repositories/firebase/firebase_firestore_repository.dart';

class FoodListController extends GetxController {
  RxList<FoodModel> foodList = <FoodModel>[].obs;
  final firestore = FirebaseFirestore.instance.collection('foods');
  final storage = FirebaseStorage.instance.ref().child('foods/');

  @override
  void onReady() async {
    super.onReady();
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

  final IServerStorage serverStorage = FirebaseFirestoreRepository();
  Future<List<FoodModel>> loadFoodList() async {
    var query = await serverStorage.getCollection('foods').get();
    List<FoodModel> list =
        query.docs.map((doc) => FoodModel.fromMap(doc.data())).toList();

    return list;
  }
}
