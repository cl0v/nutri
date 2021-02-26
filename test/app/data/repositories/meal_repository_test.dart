import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/providers/meal_provider.dart';
import 'package:nutri/app/data/repositories/meal_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

//IDEIA: Create a card that is just fruits in the entire meal (title:Fruits, extras[list of fruits], mealType.tea, mainOrExtra.main, foodcategory.none(or fruits))
//FIXME: Fruits nao deve aparecer na foodswipe, porém deve aparecer no cardapio final (SOMENTE SE ALGuMA FRUTA FOI ESCOLHIDA)
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
      expect(proteinMeals, greaterThanOrEqualTo(14));
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
  }, skip: true);

  group('Card on the dayle meals: ', () {
    /* Testar funcionalidade da FoodModel definindo se deve ser(na home) um card principal ou um card de extras
     - Nenhum card principal deve estar na categoria MainOrExtra.extra
     - Nenhum card de extra deve estar na categoria MainOrExtra.main
     - Todos os card principais devem estar na categoria MainOrExtra.main
     - Todos os card de extra devem estar na categoria MainOrExtra.extra
     -- Fruits é uma exceção, logo deverá ser testado com suas regras
     - O card de frutas deverá estar disponível, se for escolhida pelo menos uma fruta
    */
    //Esse cara vai ser responsável por pegar o error dos dois ultimos testes do grupo seguinte Sendo tomate um prato principal, sendo que ele está na categoria de extras
//TODO: Implementar sistema de verificação se o card é main ou não

    List<MealModel> dailyMeals = [];
    test('No main card should be in MainOrExtra.extra category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      var listOfMains =
          dailyMeals.map((meal) => meal.food.mainOrExtra).toList();
      expect(listOfMains, everyElement(isNot(MainOrExtra.extra)));
    });
    test('No extra card should be in MainOrExtra.main category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      var listOfExtras = [];
      dailyMeals.forEach((meal) =>
          meal.extras.forEach((extra) => listOfExtras.add(extra.mainOrExtra)));
      expect(listOfExtras, everyElement(isNot(MainOrExtra.main)));
    });
    test('Every main card should be in MainOrExtra.main category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      var listOfMains =
          dailyMeals.map((meal) => meal.food.mainOrExtra).toList();
      expect(listOfMains, everyElement(MainOrExtra.main));
    });
    test('Every extra card should be in MainOrExtra.extra category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      var listOfExtras = [];
      dailyMeals.forEach((meal) =>
          meal.extras.forEach((extra) => listOfExtras.add(extra.mainOrExtra)));
      expect(listOfExtras, everyElement(MainOrExtra.extra));
    });

    test(
        'Fruits card should be available, only if prefs have at least one FoodCategory.fruit ',
        () async {
      dailyMeals = await repository.fetchDailyMeals();
    });
  });
  //Diabéticos nao podem jejuar de manhã

  group('Daily meals for people that dont do exercice: ', () {
    /* Refeições diarias para pessoas que não fazem exercícios
    * O que preciso testar:
    - A quantidade de refeições por dia deve ser 4
    - A ordem dos pratos principais atendem as respectivas categorias [drink, meat, meat, fruit]
    - Primeira refeição deve ser alguma bebida
    - Primeira refeição não deve ter acompanhamentos
    - Segunda refeição deve ser alguma carne
    - Segunda refeição deve ser acompanhado de vegetais
    - Terceira refeição deve ser alguma carne
    - Terceira refeição deve ser acompanhado de vegetais
    - Ultima refeição deve ser o card de frutas *
    - Ultima refeição deve ser acompanhado de frutas
    */

    List<MealModel> dailyMeals = [];

    test('Total meals of the day should be 4', () async {
      dailyMeals = await repository.fetchDailyMeals();
      expect(dailyMeals.length, 4);
    });
    test(
        'The food category ordered by meal order should be drink, meat, meat and fruit',
        () async {
      dailyMeals = await repository.fetchDailyMeals();
      List<FoodCategory> foodCategoryOrderedByMeals = [];
      dailyMeals.forEach(
          (meal) => foodCategoryOrderedByMeals.add(meal.food.category));
      expect(foodCategoryOrderedByMeals, [
        FoodCategory.drink,
        FoodCategory.meat,
        FoodCategory.meat,
        FoodCategory.fruit
      ]);
    });

    test('First meal of the day should be in drink category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      expect(dailyMeals.first.food.category, FoodCategory.drink);
    });

    test('First meal of the day should not have extras', () async {
      dailyMeals = await repository.fetchDailyMeals();
      expect(dailyMeals.first.extras.length, 0);
    });

    test('Second meal of the day should be in meat category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      expect(dailyMeals[1].food.category, FoodCategory.meat);
    });

    //FIXME: Futuramente pode conter tubers(cenoura etc)
    test(
        'Second meal of the day should have only extras in vegetables category',
        () async {
      dailyMeals = await repository.fetchDailyMeals();
      List<FoodCategory> extraCategoriesFromSecondMeal = [];
      dailyMeals[1].extras.forEach(
            (extra) => extraCategoriesFromSecondMeal.add(
              extra.category,
            ),
          );

      expect(extraCategoriesFromSecondMeal.length, greaterThan(0));
      expect(
          extraCategoriesFromSecondMeal, everyElement(FoodCategory.vegetable));
    });
    test('Third meal of the day should be in meat category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      expect(dailyMeals[2].food.category, FoodCategory.meat);
    });

    //FIXME: Futuramente pode conter tubers(cenoura etc)
    test('Third meal of the day should have only extras in vegetables category',
        () async {
      dailyMeals = await repository.fetchDailyMeals();
      List<FoodCategory> extraCategoriesFromThirdMeal = [];

      dailyMeals[2].extras.forEach(
            (extra) => extraCategoriesFromThirdMeal.add(
              extra.category,
            ),
          );

      expect(extraCategoriesFromThirdMeal.length, greaterThan(0));
      expect(
          extraCategoriesFromThirdMeal, everyElement(FoodCategory.vegetable));
    });

    test('Last meal of the day should be in fruit category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      expect(dailyMeals[3].food.category, FoodCategory.fruit);
    });

    test('Last meal of the day should have only extras in fruits category',
        () async {
      dailyMeals = await repository.fetchDailyMeals();
      List<FoodCategory> extraCategoriesFromLastMeal = [];

      dailyMeals.last.extras.forEach(
        (extra) => extraCategoriesFromLastMeal.add(
          extra.category,
        ),
      );
      expect(extraCategoriesFromLastMeal.length, greaterThan(0));
      expect(extraCategoriesFromLastMeal, everyElement(FoodCategory.fruit));
    });
  });
}
// test('Extras from meat should be vegetables')//testar os extras
//Testar a quantidade de vezes que cada um aparece(tirar a randomizaçao)

//FIXME: Limitar o número de carboidratos
//Testar a quantidade de extras que pode ser selecionado cada dia
//Para pessoas que nao praticam atividade fisica, apenas uma opção de fruta já é o suficiente
// IDEIA: Apenas uma variedade de fruta para cada dia

// Pratos Principais: Frutas, Proteinas, Bebidas(nao caloricas)
// Acompanhamentos: Sempre será vegetal, (decidir dos ovos ainda)
// Acompanhamentos não deverá possuir Carne, bebidas ou frutas(carb)
// Criar um prato principal que se chame frutas, os acompanhamentos mostrarão as frutas
// Posso criar uma categoria de frutas que seja acompanhamentos

//IDEIA: É importante saber qual o objetivo da pessoa(Emagrecimento, etc)
// - Deixar as pessoas que querem engordar e manter peso por ultimo
// É importante saber o quão rápido a pessoa pretende atingir o objetivo.
//Para pessoas que praticam atividade física moderada ou de alta intensidade, é importante saber o horario dos exercicios.
//Para pessoas que praticam atividade fisica de manha, a atividade deverá ser feita em jejum
//Para pessoas que não praticam atividade fisica, é indiferente

/*
Serão 4 refeiçoes por dia contando o cafe na parte da manha.
- Sendo a primeira refeiçao obrigatório alguma bebida sem calorias
- Sendo o almoço, a refeição principal com base em proteína animal, mais vegetais
- Sendo a refeição seguinte, uma refeição com base em proteina animal, mais vegetais
- Sendo uma refeiçao com base em frutas (apenas 100g de carb ja que essa pessoa nao pratica atividade fisica)
*/

//.Exemplo padrao de combinaçao pode ser encontrado no livro
//1
/* Reforçando que essa pessoa não pratica exercicios fisicos, acorda as 7 e dorme as 11
  - Cafe da manha: Café preto, sem acompanhamento
  - Almoço: Peito de frango, acompanhado de vegetais
  - Sem café da tarde
  - Entre 5 e 7 da noite, Carne, acompanhado de vegetais
  - Entre 9 e 11, Frutas, limitar a somente uma ou duas frutas por dia
*/

//2
/* Uma pessoa que pratica atividade fisica, acorda as 7 e dorme as 11 (Musculaçao)
// Preciso saber por volta de que horas ela malha, antes de malhar recomendar frutas, o quanto ela quiser
  - Cafe da manha: Café preto, sem acompanhamento
  - Almoço: Peito de frango, acompanhado de vegetais
  - Antes de malhar, Frutas, limitar a somente uma ou duas frutas por dia
  - Entre 9 e 11 da noite, Carne, acompanhado de vegetais
*/

//IDEIA: Lembrar do objetivo emagrecer e o quanto ela está disposta a 'sofrer',
// emagrecer de forma rigorosa, limitar a 1 ou 2 refeiçoes por dia + cafe
// por enquanto vou trabalhar com uma medida padrão que funcionaria para qualquer pessoa
