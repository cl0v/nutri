import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/pages/home/models/overview_model.dart';

class MenuModel {
  OverviewModel overview;
  List<FoodModel> mainFoodList;
  List<FoodModel> extraList;
  
  MenuModel({
    required this.overview,
    required this.mainFoodList,
    required this.extraList,
  });
}

