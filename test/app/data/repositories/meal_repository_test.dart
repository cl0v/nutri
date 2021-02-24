import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/providers/meal_provider.dart';
import 'package:nutri/app/data/repositories/meal_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({foodPrefsKey: mockedPrefs});
  final prefs = SharedPreferences.getInstance();
  final provider = MealProvider(
    prefs: prefs,
  );
  MealRepository repository = MealRepository(
    provider: provider,
  );
  group('fetchMealsOfTheWeek', () {
    List<List<MealModel>> weekMeals;

    test('Asserting the right prefs', () async {
      weekMeals = await repository.fetchMealsOfTheWeek();
      var expected = await provider.getFoodsPrefs();
      expect(expected, mockedPrefs);
    });

// Tem que ser 7 pois sao 7 dias na semana
// A lista de dentro pode varias a quantidade com base na pessoa;
// PEssoa que escolhe a dieta mais agressiva, pode comer 3 x por dia(incluindo cafe na manha)
// Eu recebo essa lista de lista e o index será o dia da semana(contando do dia que fez o foodswipe semanal)
// Decidir quantas comidas a pessoa comerá por dia, mas irei começar em 3
    test('Asserting the 7 days of the week', () async {
      weekMeals = await repository.fetchMealsOfTheWeek();
      expect(weekMeals.length, 7);
    });
    test(
        'Asserting the 28 meat based meals in a week, based on 3 main meals a day, cause of breakfast coffee',
        () async {
      weekMeals = await repository.fetchMealsOfTheWeek();
      int meals = 0;
      weekMeals.forEach(
        (mealList) => mealList.forEach(
          (meal) {
            if (meal.food.category == FoodCategory.meat) meals++;
          },
        ),
      );
      expect(meals, 28);
    });

    test('Every first meal shoul be breakfast and is in the BreakFastCategory',
        () async {
      weekMeals = await repository.fetchMealsOfTheWeek();
      List list = [];
      weekMeals.forEach((dailyMeal) {
        if (dailyMeal.first.mealType == MealType.breakfast &&
            dailyMeal.first.food.category == FoodCategory.drink)
          list.add(dailyMeal.first.mealType);
      });
      expect(list.length, 7);
    });

    test('At lest 2 meals shoul have protein', () async {
      weekMeals = await repository.fetchMealsOfTheWeek();
      int proteinMeals = 0;
      weekMeals.forEach(
        (mealList) => mealList.forEach(
          (meal) {
            if (meal.food.category == FoodCategory.meat) proteinMeals++;
          },
        ),
      );
      expect(proteinMeals, greaterThan(7 * 2));
    });
    test('First meal should be coffee, if the prefs have only the coffee drink',
        () async {
      //se a unica bebida escolhida no prefs for cafe, o primeiro item de qualquer dia da semana será café
      expect(weekMeals.first.first.food.title, 'Café');
    }, skip: true);
  });
}

final mockedPrefs = [
  'Peito de Frango',
  'Picanha',
  'Brócolis',
  'Alface',
  'Tomate',
  'Café Preto'
];
