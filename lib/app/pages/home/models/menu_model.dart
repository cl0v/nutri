import 'package:nutri/app/models/diet_model.dart';

import 'home_model.dart';

class MenuModel extends HomeModel {
  MenuModel({
    required meal,
    required mainFoodList,
    required extraFoodList,
  }) : super(
          meal: meal,
          mainFoodList: mainFoodList,
          extraFoodList: extraFoodList,
        );

  factory MenuModel.fromDietModel(DietModel diet) { //TODO: Ver como remover isso
    return MenuModel(
      meal: diet.meal,
      mainFoodList: diet.mainFoodList,
      extraFoodList: diet.extraFoodList,
    );
  }

}
