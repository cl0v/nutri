import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/home_card_model.dart';
import 'package:nutri/app/providers/meal_provider.dart';

abstract class IMealCardBloc {
  Future<List<MealCardModel>> fetchMealCardList(String day);
  Future saveMealCard(String day, MealCardModel homeCard);
}

class MealCardViewModel implements IMealCardBloc {
  final IMealProvider mealProvider;
  final ILocalStorage storage;

  MealCardViewModel({
    required this.mealProvider,
    required this.storage,
  });

  @override
  Future<List<MealCardModel>> fetchMealCardList(String day) async {
    var mealList = <MealCardModel>[];
    for (var type in MealType.values) {
      var meal = await fetchMealCardFromDB(day, type);
      if (meal == null) meal = await fetchMealCardFromMealProvider(day, type);
      mealList.add(meal);
    }

    return mealList;
  }

  @override
  Future saveMealCard(String day, MealCardModel homeCard) async {
    await storage.put('$day/${homeCard.type.toString()}', homeCard.toJson());
  }

  Future<MealCardModel?> fetchMealCardFromDB(String day, MealType type) async {
    try {
      var json = await storage.get('$day/${type.toString()}');
      return MealCardModel.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  Future<MealCardModel> fetchMealCardFromMealProvider(
      String day, MealType type) async {
    var meal = await mealProvider.fetchMeal(day, type);
    return MealCardModel.fromMealModel(meal);
  }
}
