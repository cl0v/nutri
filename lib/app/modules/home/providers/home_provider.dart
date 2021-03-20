import 'dart:async';

import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/modules/home/helpers/home_helper.dart';
import 'package:nutri/app/modules/home/models/meal_model.dart';
import 'package:nutri/app/modules/home/models/menu_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

const pageIndexKey = 'pageIndexKey';
const dayIndexKey = 'dayIndexKey';
const savedMealCardListPrefsKey = 'savedMealCardListPrefsKey';

enum HomeState {
  Ok,
  Idle,
  Error,
}

class HomeProvider {
  final Future<SharedPreferences> sharedPreferences;

  var weekDay = DateTime.now().weekday;

  HomeProvider({required this.sharedPreferences});

  Stream<HomeState> getHomeState() => homeStateOutput;
  closeHomeStream() => homeStateController.close();

  String getDayTitle({int day = 1}) => HomeHelper.getDayTitle(day, weekDay);

  Future<List<MenuModel>> fetchDailyMeals() async =>
      _fetchDailyMeals(await sharedPreferences, day: weekDay);

  Future<List<List<MenuModel>>> fetchMealsOfTheWeek() async =>
      _fetchWeeklyMeals(await sharedPreferences);

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
  Future<List<List<MenuModel>>> _fetchWeeklyMeals(sharedPreferences) async {
    List foodPrefs = _getFoodPrefs(sharedPreferences);
    if (foodPrefs.isEmpty) {
      homeStateInput.add(HomeState.Error);
      return [];
    } else {
      var weeklyMeals = _getWeeklyMeals(sharedPreferences);
      homeStateInput.add(HomeState.Ok);
      if (weeklyMeals.isEmpty)
        return _buildMealsOfTheWeek(sharedPreferences);
      else
        return weeklyMeals;
    }
  }

  Future<List<MenuModel>> _fetchDailyMeals(sharedPreferences,
      {int day = 0}) async {
    //TODO: Aqui que deve ser chamado o builde semanal
    var weeklyMeals =
        await _fetchWeeklyMeals(sharedPreferences); //FIXME:erro aq

    return weeklyMeals.isNotEmpty
        ? weeklyMeals[day]
        : []; //TODO: Remover esse dia menos 1
  }

  Future<List<List<MenuModel>>> _buildMealsOfTheWeek(sharedPreferences) async {
    List<List<MenuModel>> listOfDailyMeal = [];
    for (var i = 1; i <= daysInAWeek; i++) {
      var dailyMeal = await _buildDailyMeal(sharedPreferences);
      listOfDailyMeal.add(dailyMeal);
    }
    await _saveWeeklyMeals(sharedPreferences, listOfDailyMeal);
    return listOfDailyMeal;
  }

  Future<List<MenuModel>> _buildDailyMeal(sharedPreferences) async {
    var breakfast = await MenuProviderHelper.buildBreakfast(sharedPreferences);
    var lunch = await MenuProviderHelper.buildLunch(sharedPreferences);
    var snack = await MenuProviderHelper.buildSnack(sharedPreferences);
    var dinner = await MenuProviderHelper.buildDinner(sharedPreferences);

    return [breakfast, lunch, snack, dinner];
  }

  _getFoodPrefs(sharedPreferences) =>
      FoodProvider.getFoodsPrefsList(sharedPreferences);

  List<List<MenuModel>> _getWeeklyMeals(sharedPreferences) =>
      MenuProvider.getWeeklyMealsFromPrefs(sharedPreferences);

  Future<List<List<MenuModel>>> _saveWeeklyMeals(
          sharedPreferences, List<List<MenuModel>> listOfDailyMeal) async =>
      MenuProvider.saveWeeklyMealsOnPrefs(
          await sharedPreferences, listOfDailyMeal);

  Future<int> getPageIndexFromPrefs() async {
    var lastSavedDay = (await sharedPreferences).getInt(dayIndexKey);
    if (lastSavedDay == weekDay)
      return (await sharedPreferences).getInt(pageIndexKey) ?? 0;
    return 0;
  }

  setPageIndexOnPrefs(int mealIdx) async {
    var prefs = (await sharedPreferences);
    prefs.setInt(dayIndexKey, weekDay);
    prefs.setInt(pageIndexKey, mealIdx);
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
      var val = (await sharedPreferences).getString('mealType $mealType');
      if (val != null) list.add(val);
    });
    return list;
  }

  saveMealCard(String mealType, String s) async {
    (await sharedPreferences).setString('mealType $mealType', s);
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