import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/food_swipe_model.dart';
import 'package:nutri/app/data/providers/food_provider.dart';

class FoodSwipeProvider {
  FoodProvider _foodProvider = FoodProvider();

  Future<List<FoodSwipeModel>> loadFoodSwipeList() async =>
      _buildFoodSwipeList();


  Future<List<FoodSwipeModel>> _buildFoodSwipeList() async {
    //TODO: Esse carinha vai decidir quais comidas sortear
    List<FoodSwipeModel> foodSwipeList = [];
    var meatList = await _foodProvider.loadMeats();
    var drinkList = await _foodProvider.loadDrinks();
    var vegList = await _foodProvider.loadVegetables();
    var fruitList = await _foodProvider.loadFruits();
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
}
