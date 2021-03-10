import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/food_swipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const foodPrefsKey = 'foodPrefs';

class FoodSwipeProvider {
  final Future<SharedPreferences> prefs;

  FoodSwipeProvider({@required this.prefs});

  Future<List<FoodSwipeModel>> loadFoodSwipeList() async =>
      _buildFoodSwipeList();

//IDEIA: Quanto maior o valor da intensidade do exercício, mais frutas recomendar
// 0 ... 3 (até no maximo de 400g de carboidratos) com base na variavel de intensidade do exercicio

  ///Decide quais comidas deverão ser mostradas pro usuário
  //Deverá se basear no perfil do usuário
  Future<List<FoodSwipeModel>> _buildFoodSwipeList() async {
    List<FoodSwipeModel> foodSwipeList = [];
    var meatList = await FoodModelHelper.loadMeats();
    var drinkList = await FoodModelHelper.loadDrinks();
    var vegList = await FoodModelHelper.loadVegetables();
    var lowSugarFruitList = await FoodModelHelper.loadLowSugarFruits();
    var tubersList = await FoodModelHelper.loadTubers();

    foodSwipeList.add(
      FoodSwipeModel(
        maximum: 7,
        minimum: 3,
        category: FoodSwipeModel.getCategory(FoodCategory.meat),
        foods: meatList,
      ),
    );
    foodSwipeList.add(
      FoodSwipeModel(
        maximum: 9, // TODO: Quando nao tem maximo, o que fazer?
        minimum: 3, // TODO: Como mostrar ao usuário a quantidade minima?
        category: FoodSwipeModel.getCategory(FoodCategory.vegetable),
        foods: vegList,
      ),
    );
    foodSwipeList.add(
      FoodSwipeModel(
        maximum: 9,
        minimum: 3,
        category: FoodSwipeModel.getCategory(FoodCategory.lowSugarFruits),
        foods: lowSugarFruitList,
      ),
    );
    foodSwipeList.add(
      FoodSwipeModel(
        maximum: 5,
        minimum: 3,
        category: FoodSwipeModel.getCategory(FoodCategory.tuber),
        foods: tubersList,
      ),
    );
    foodSwipeList.add(
      FoodSwipeModel(
        maximum: 3,
        minimum: 1,
        category: FoodSwipeModel.getCategory(FoodCategory.drink),
        foods: drinkList,
      ),
    );
    return foodSwipeList;
  }

  Future setFoodsPrefs(List<String> foodPrefs) async =>
      await (await prefs).setStringList(foodPrefsKey, foodPrefs);
}
