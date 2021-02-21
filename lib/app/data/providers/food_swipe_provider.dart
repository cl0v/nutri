import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/food_swipe_model.dart';
import 'package:nutri/app/data/providers/food_provider.dart';

class FoodSwipeProvider {
  FoodProvider _foodProvider = FoodProvider();

// FoodSwipeProvider();
//TODO: Talvez importar o provider??

  Future<List<FoodSwipeModel>> loadFoodSwipeList() async =>
      _buildFoodSwipeList();

  Future<List<FoodSwipeModel>> _buildFoodSwipeList() async {
    //TODO: Esse carinha vai decidir quais comidas sortear
    List<FoodSwipeModel> foodSwipeList = [];
    var meatList = await _foodProvider.loadDrinks();
    foodSwipeList.add(
      FoodSwipeModel(
        amount: 7,
        category: FoodSwipeModel.getCategory(FoodCategory.drink),
        foods: meatList,
      ),
    );
    return foodSwipeList;
  }
}
