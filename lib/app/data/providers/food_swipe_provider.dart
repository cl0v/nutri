import 'package:flutter/foundation.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/food_swipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const foodPrefsKey = 'foodPrefs';
//FIXME: Trava a home quando nenhum item foi escolhido

class FoodSwipeProvider {
  final Future<SharedPreferences> prefs;

  //IDEIA: Supondo que a pessoa não faça atividade fisica
  // var exerciceIntensity = 0;

  FoodSwipeProvider({@required this.prefs});

  Future<List<FoodSwipeModel>> loadFoodSwipeList() async =>
      _buildFoodSwipeList();

//IDEIA: Quanto maior o valor da intensidade do exercício, mais frutas recomendar
// 0 ... 3 (até no maximo de 400g de carboidratos)

  ///Decide quais comidas deverão ser mostradas pro usuário com base no perfil
  Future<List<FoodSwipeModel>> _buildFoodSwipeList() async {
    List<FoodSwipeModel> foodSwipeList = [];
    var meatList = await FoodModelHelper.loadMeats();
    var drinkList = await FoodModelHelper.loadDrinks();
    var vegList = await FoodModelHelper.loadVegetables();
    var fruitList = await FoodModelHelper.loadFruitsWithouFruitCard();
    foodSwipeList.add(
      FoodSwipeModel(
        maximum: 3,
        minimum: 2,
        category: FoodSwipeModel.getCategory(FoodCategory.meat),
        foods: meatList,
      ),
    );
    foodSwipeList.add(
      FoodSwipeModel(
        maximum: 9,
        minimum: 3,
        category: FoodSwipeModel.getCategory(FoodCategory.vegetable),
        foods: vegList,
      ),
    );
    foodSwipeList.add(
      FoodSwipeModel(
        maximum: 1,
        minimum: 0,
        category: FoodSwipeModel.getCategory(FoodCategory.fruit),
        foods: fruitList,
      ),
    );
    foodSwipeList.add(
      FoodSwipeModel(
        maximum: 2,
        minimum: 1,
        category: FoodSwipeModel.getCategory(FoodCategory.drink),
        foods: drinkList,
      ),
    );
    return foodSwipeList;
  }

  void setFoodsPrefs(List<String> foodPrefs) async =>
      (await prefs).setStringList(foodPrefsKey, foodPrefs);
}
