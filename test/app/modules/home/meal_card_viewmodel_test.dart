import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/home_card_model.dart';
import 'package:nutri/app/pages/home/meal_card_viewmodel.dart';
import 'package:nutri/app/providers/meal_provider.dart';
import 'package:nutri/app/services/shared_local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues(sharedPreferencesInitialValues);

  ILocalStorage storage = SharedLocalStorageService();
  IMealProvider mealProvider = MealProvider(storage: storage);
  MealCardViewModel mealCardBloc = MealCardViewModel(
    mealProvider: mealProvider,
    storage: storage,
  );

  test('fetchMealCard method sucess', () async {
    var meal = await mealCardBloc.fetchMealCardFromDB(day, type);
    expect(meal!.type, equals(type));
  });
  test('fetchMealCard method sucess', () async {
    var meal = await mealCardBloc.fetchMealCardFromDB(day, type);
    expect(meal!.status, equals(MealCardStatus.Done));
  });

  test('fetchMealCard method null case', () async {
    var meal = await mealCardBloc.fetchMealCardFromDB(day, MealType.dinner);
    expect(meal, null);
  });

  test('fetchMealCardList list have aways 4 elements', () async {
    var mealList = await mealCardBloc.fetchMealCardList(day);
    expect(mealList.length, equals(4));
  });

  test('fetchMealCardFromMealProvider', () async {
    var meal = await mealCardBloc.fetchMealCardFromMealProvider(
        'any', MealType.breakfast);
    expect(meal.status, equals(MealCardStatus.None));
  });
}

String day = '01/01/2021';
MealType type = MealType.breakfast;

MealCardModel mealCardModel = MealCardModel(
  meal: MealModel(
    type: type,
    img: 'img',
    title: 'title',
  ),
  status: MealCardStatus.Done,
);

Map<String, Object> sharedPreferencesInitialValues = {
  '$day/${type.toString()}': mealCardModel.toJson()
};
