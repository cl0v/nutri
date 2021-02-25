import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/food_swipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const foodPrefsKey = 'foodPrefs';
//FIXME: Trava a home quando nenhum item foi escolhido

class FoodSwipeProvider {
  final Future<SharedPreferences> prefs;

  //IDEIA: Supondo que a pessoa não faça atividade fisica
  var exerciceIntensity = 0;

  FoodSwipeProvider({@required this.prefs});

  Future<List<FoodSwipeModel>> loadFoodSwipeList() async =>
      _buildFoodSwipeList();

//IDEIA: Quanto maior o valor da intensidade do exercício, mais frutas recomendar
// 0 ... 3

  filterBasedOnExerciceIntensity() => _filterBasedOnExerciceIntensity();


  _filterBasedOnExerciceIntensity() {}

  ///Decide quais comidas deverão ser mostradas pro usuário com base no perfil
  Future<List<FoodSwipeModel>> _buildFoodSwipeList() async {
    List<FoodSwipeModel> foodSwipeList = [];
    var meatList = await FoodModelHelper.loadMeats();
    var drinkList = await FoodModelHelper.loadDrinks();
    var vegList = await FoodModelHelper.loadVegetables();
    var fruitList = await FoodModelHelper.loadFruits();
    foodSwipeList.add(
      FoodSwipeModel(
        amount: 3,
        category: FoodSwipeModel.getCategory(FoodCategory.meat),
        foods: meatList,
      ),
    );
    foodSwipeList.add(
      FoodSwipeModel(
        amount: 2,
        category: FoodSwipeModel.getCategory(FoodCategory.vegetable),
        foods: vegList,
      ),
    );
    foodSwipeList.add(
      FoodSwipeModel(
        amount: 1,
        category: FoodSwipeModel.getCategory(FoodCategory.fruit),
        foods: fruitList,
      ),
    );
    foodSwipeList.add(
      FoodSwipeModel(
        amount: 2,
        category: FoodSwipeModel.getCategory(FoodCategory.drink),
        foods: drinkList,
      ),
    );
    return foodSwipeList;
  }

  void setFoodsPrefs(List<String> foodPrefs) async =>
      (await prefs).setStringList(foodPrefsKey, foodPrefs);
}
