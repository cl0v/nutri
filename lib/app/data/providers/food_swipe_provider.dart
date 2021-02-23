import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/food_swipe_model.dart';

class FoodSwipeProvider {

  Future<List<FoodSwipeModel>> loadFoodSwipeList() async =>
      _buildFoodSwipeList();


  Future<List<FoodSwipeModel>> _buildFoodSwipeList() async {
    //IDEIA: Esse carinha vai decidir quais comidas sortear
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
}
