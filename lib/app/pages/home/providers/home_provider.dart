import 'dart:async';

import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/helpers/home_helper.dart';
import 'package:nutri/app/pages/home/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';
import 'package:rxdart/rxdart.dart';

const pageIndexKey = 'pageIndexKey';
const dayIndexKey = 'dayIndexKey';
const savedMealCardListPrefsKey = 'savedMealCardListPrefsKey';

enum HomeState {
  Ok,
  Idle,
  Error,
}

class HomeProvider {
  ILocalStorage storage;

  var weekDay = DateTime.now().weekday;

  HomeProvider({required this.storage});

  Stream<HomeState> getHomeState() => homeStateOutput;
  closeHomeStream() => homeStateController.close();

  String getDayTitle({int day = 1}) => HomeHelper.getDayTitle(day, weekDay);

  Future<List<MenuModel>> fetchDailyMeals() async =>
      _fetchDailyMeals(storage, day: weekDay);

  Future<List<List<MenuModel>>> fetchMealsOfTheWeek() async =>
      _fetchWeeklyMeals(storage);

  int daysInAWeek = 7;

  Future<List<OverviewModel>> getOverViewListFromPEDietSugestion() =>
      PeDiet().getOverViewListFromPEDietSugestion(weekDay);

//TODO: Implement getOverViewListFromPEDietSugestion

  Future<List<MenuModel>> getMenuListFromPEDietSugestion() =>
      PeDiet().getMenuListFromPEDietSugestion();
//TODO: Implement getMenuListFromPEDietSugestion

  Future<List<OverviewModel>> getMeals({int day = 1}) async {
    return await MealProvider.loadMealListByDay(day);
  }

  BehaviorSubject<HomeState> homeStateController =
      BehaviorSubject.seeded(HomeState.Idle);
  Stream<HomeState> get homeStateOutput => homeStateController.stream;
  Sink<HomeState> get homeStateInput => homeStateController.sink;

//TODO: Remover temporariamente
  Future<List<List<MenuModel>>> _fetchWeeklyMeals(storage) async {
    List foodPrefs = _getFoodPrefs(storage);
    if (foodPrefs.isEmpty) {
      homeStateInput.add(HomeState.Error);
      return [];
    } else {
      var weeklyMeals = await _getWeeklyMeals(storage);
      homeStateInput.add(HomeState.Ok);
      if (weeklyMeals.isEmpty)
        return _buildMealsOfTheWeek(storage);
      else
        return weeklyMeals;
    }
  }

  Future<List<MenuModel>> _fetchDailyMeals(storage,
      {int day = 0}) async {
    //TODO: Aqui que deve ser chamado o builde semanal
    var weeklyMeals =
        await _fetchWeeklyMeals(storage); //FIXME:erro aq

    return weeklyMeals.isNotEmpty
        ? weeklyMeals[day]
        : []; //TODO: Remover esse dia menos 1
  }

  Future<List<List<MenuModel>>> _buildMealsOfTheWeek(storage) async {
    List<List<MenuModel>> listOfDailyMeal = [];
    for (var i = 1; i <= daysInAWeek; i++) {
      var dailyMeal = await _buildDailyMeal(storage);
      listOfDailyMeal.add(dailyMeal);
    }
    await _saveWeeklyMeals(storage, listOfDailyMeal);
    return listOfDailyMeal;
  }

  Future<List<MenuModel>> _buildDailyMeal(storage) async {
    var breakfast = await MenuProviderHelper.buildBreakfast(storage);
    var lunch = await MenuProviderHelper.buildLunch(storage);
    var snack = await MenuProviderHelper.buildSnack(storage);
    var dinner = await MenuProviderHelper.buildDinner(storage);

    return [breakfast, lunch, snack, dinner];
  }

//DONE
  _getFoodPrefs(storage) =>
      FoodProvider.getFoodsPrefsList(storage);

  Future<List<List<MenuModel>>> _getWeeklyMeals(storage) =>
      MenuProvider.getWeeklyMealsFromPrefs(storage);

  Future<List<List<MenuModel>>> _saveWeeklyMeals(
          storage, List<List<MenuModel>> listOfDailyMeal) async =>
      MenuProvider.saveWeeklyMealsOnPrefs(
          await storage, listOfDailyMeal);

  Future<int> getPageIndexFromPrefs() async {
    var lastSavedDay = await storage.get(dayIndexKey);
    if (lastSavedDay == weekDay)
      return await storage.get(pageIndexKey) ?? 0;
    return 0;
  }

  setPageIndexOnPrefs(int mealIdx) async {
    storage.put(dayIndexKey, weekDay);
    storage.put(pageIndexKey, mealIdx);
  }

  Future<List<String>> getMealsCard() async {
    List<String> mealTypeStringList = [
      MealType.breakfast.toString(),
      MealType.lunch.toString(),
      MealType.snack.toString(),
      MealType.dinner.toString(),
    ];

    List<String> list = [];
    mealTypeStringList.forEach((mealType) async {
      var val = storage.get('mealType $mealType');
    });
    return list;
  }

  saveMealCard(String mealType, String s) async {
    storage.put('mealType $mealType', s);
    // meals of the day tipo lista de string;
  }
}

/// Tudo que tiver relação com a dieta PE está nessa classe
class PeDiet {
  Future<List<OverviewModel>> getOverViewListFromPEDietSugestion(day) =>
      MealProvider.loadMealListByDay(day);
//TODO: Implement getOverViewListFromPEDietSugestion

  Future<List<MenuModel>> getMenuListFromPEDietSugestion() =>
      MenuProvider.peDiet();
//TODO: Implement getMenuListFromPEDietSugestion

}
// Posso criar uma classe de dieta que é extendida por outras dietas