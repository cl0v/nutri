import 'package:get/get.dart';
import 'package:nutri/app/data/model/food_model.dart';

class FoodSwipeController extends GetxController {

  List<FoodModel> foodList = itens.map((map) => FoodModel.fromJson(map)).toList();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}




const itens = [
  {
    'title': 'Test',
    'text': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam gravida venenatis diam, sed posuere turpis aliquam elementum. Vivamus at leo metus. Nunc faucibus bibendum turpis, a ornare ipsum.',
    'image': 'https://images.unsplash.com/photo-1547721064-da6cfb341d50?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=668&q=80',
  },
  {
    'title': 'Test',
    'text': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam gravida venenatis diam, sed posuere turpis aliquam elementum. Vivamus at leo metus. Nunc faucibus bibendum turpis, a ornare ipsum.',
    'image': 'https://images.unsplash.com/photo-1552053831-71594a27632d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=624&q=80',
  },
  {
    'title': 'Test',
    'text': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam gravida venenatis diam, sed posuere turpis aliquam elementum. Vivamus at leo metus. Nunc faucibus bibendum turpis, a ornare ipsum.',
    'image': 'https://images.unsplash.com/photo-1552728089-57bdde30beb3?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=734&q=80',
  },
  {
    'title': 'Test',
    'text': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam gravida venenatis diam, sed posuere turpis aliquam elementum. Vivamus at leo metus. Nunc faucibus bibendum turpis, a ornare ipsum.',
    'image': 'https://images.unsplash.com/photo-1561948955-570b270e7c36?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=518&q=80',
  },
  {
    'title': 'Test',
    'text': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam gravida venenatis diam, sed posuere turpis aliquam elementum. Vivamus at leo metus. Nunc faucibus bibendum turpis, a ornare ipsum.',
    'image': 'https://images.unsplash.com/photo-1589656966895-2f33e7653819?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
  },
];
