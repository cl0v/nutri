import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/providers/meal_provider.dart';
import 'package:nutri/app/data/repositories/meal_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

//IDEIA: Create a card that is just fruits in the entire meal (title:Fruits, extras[list of fruits], mealType.tea, mainOrExtra.main, foodcategory.none(or fruits))

// Criar uma lista que armazena o que a pessoa tem que comer

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
  group('fetchMealsOfTheWeek: ', () {
    List<List<MealModel>> weekMeals;

// Tem que ser 7 pois sao 7 dias na semana
// A lista de dentro pode varias a quantidade com base na pessoa;
// PEssoa que escolhe a dieta mais agressiva, pode comer 3 x por dia(incluindo cafe na manha)
// Eu recebo essa lista de lista e o index será o dia da semana(contando do dia que fez o foodswipe semanal)
// Decidir quantas comidas a pessoa comerá por dia, mas irei começar em 3
    test('Asserting the lenght of 7 list of meals on the week', () async {
      weekMeals = await repository.fetchMealsOfTheWeek();
      expect(weekMeals.length, 7);
    });
    test(
        'Asserting the 28 meals in a week, based on 3 main meals a day plus coffee on breakfast',
        () async {
      weekMeals = await repository.fetchMealsOfTheWeek();
      weekMeals.shuffle();
      expect(weekMeals.length * weekMeals.first.length, 28);
    });

    test('Every first meal should be breakfast and is in the BreakFastCategory',
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

    test('At lest 2 meals should have protein, based on at least 4 meals a day',
        () async {
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
    test('First meal should be some non-calories drink', () async {
      expect(weekMeals.first.first.food.category, FoodCategory.drink);
    });

    // test('Asserting the right prefs', () async {
    //   weekMeals = await repository.fetchMealsOfTheWeek();
    //   var expected = await provider.getFoodsPrefs();
    //   expect(expected, mockedPrefs);
    // });

    test('Foods in the meals is based on prefs(choosed by user', () async {
      weekMeals = await repository.fetchMealsOfTheWeek();
      List<String> foodList = [];
      weekMeals.forEach(
        (dailyMeal) => dailyMeal.forEach(
          (meal) => foodList.add(meal.food.title),
        ),
      );
      expect(foodList, everyElement(isIn(mockedPrefs)));
    });

    test('Main Foods in the week should have every MAIN foods from prefs',
        () async {
//As comidas principais devem ser pratos com proteinas, bebidas ou frutas?
      weekMeals = await repository.fetchMealsOfTheWeek();
      List<String> foodList = [];
      weekMeals.forEach(
        (dailyMeal) => dailyMeal.forEach(
          (meal) => foodList.add(meal.food.title),
        ),
      );
      expect(foodList, containsAll(mockedMainFoodPrefs));
    });
    //TODO: Testar a nao repetição dos extras quando tiver mais extras
    test('Extras in lunch should be the extras saved in prefs', () async {
      weekMeals = await repository.fetchMealsOfTheWeek();

      var allExtras = [];

      weekMeals
          .map((dailyMeal) =>
              dailyMeal.firstWhere((meal) => meal.mealType == MealType.lunch))
          .toList()
          .forEach(
            (meal) => meal.extras.forEach(
              (extra) => allExtras.add(extra.title),
            ),
          );

      expect(allExtras, containsAll(['Brócolis', 'Alface']));
    });

    test('Every lunch should have 2 extras, cause of the selected prefs',
        () async {
      weekMeals = await repository.fetchMealsOfTheWeek();
      var listExtraAmount = [];

      listExtraAmount = weekMeals
          .map(
            (dailyMeal) => dailyMeal
                .firstWhere((a) => a.mealType == MealType.lunch)
                .extras
                .length,
          )
          .toList();

      expect(listExtraAmount, everyElement(2));
    });

    // test('Extras from meat should be vegetables')//testar os extras
    //Testar a quantidade de vezes que cada um aparece(tirar a randomizaçao)
  });
}

// Pratos Principais: Frutas, Proteinas, Bebidas(nao caloricas)
// Acompanhamentos: Sempre será vegetal, (decidir dos ovos ainda)
// Acompanhamentos não deverá possuir Carne, bebidas ou frutas(carb)
// Criar um prato principal que se chame frutas, os acompanhamentos mostrarão as frutas
// Posso criar uma categoria de frutas que seja acompanhamentos

final mockedPrefs = [
  'Peito de Frango',
  'Picanha',
  'Brócolis',
  'Alface',
  'Tomate',
  'Café Preto',
];

final mockedMainFoodPrefs = [
  'Peito de Frango',
  'Café Preto',
  'Picanha',
];

//Erro estranho acontece quando troco a picanha de lugar
