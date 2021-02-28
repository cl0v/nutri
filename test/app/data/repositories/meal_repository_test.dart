import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/providers/meal_provider.dart';
import 'package:nutri/app/data/repositories/meal_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO: Testar a nao repetição dos extras quando tiver mais de um extra
//TODO: Criar sugestão de acompanhamentos para preencher os 9 espaços

//IDEIA: Sugerir uma fruta diferente, porém nao remover a fruta da lista(podendo assim, o usuario comer uma mesma fruta mais de uma vez na semana);

final mockedFoodPrefs = [
  'Peito de Frango',
  'Picanha',
  'Brócolis',
  'Alface',
  'Tomate',
  'Café Preto',
];

final mockedFoodPrefsWithoutFruit = [
  'Peito de Frango',
  'Picanha',
  'Brócolis',
  'Alface',
  'Café Preto',
];

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({foodPrefsKey: mockedFoodPrefs});
  final prefs = SharedPreferences.getInstance();
  final provider = MealProvider(
    prefs: prefs,
  );
  MealRepository repository = MealRepository(
    provider: provider,
  );

  group('Testing cards on the daily meals: ', () {
    /* Testar funcionalidade da FoodModel definindo se deve ser(na home) um card principal ou um card de extras
     - Nenhum card principal deve estar na categoria MainOrExtra.extra
     - Nenhum card de extra deve estar na categoria MainOrExtra.main
     - Todos os card principais devem estar na categoria MainOrExtra.main ou MainOrExtra.both
     - Todos os card de extra devem estar na categoria MainOrExtra.extra ou MainOrExtra.both
    */

//TODO: O foodSwipe nao deverá mostrar fruits como uma opção na categoria de frutas

    SharedPreferences.getInstance().then((prefs) async =>
        await prefs.setStringList(foodPrefsKey, mockedFoodPrefs));

    List<MealModel> dailyMeals = [];
    test('No main card should be in MainOrExtra.extra category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      var listOfMains =
          dailyMeals.map((meal) => meal.mainFood.mainOrExtra).toList();
      expect(listOfMains, everyElement(isNot(MainOrExtra.extra)));
    });

    test('No extra card should be in MainOrExtra.main category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      var listOfExtras = [];
      dailyMeals.forEach((meal) =>
          meal.extras.forEach((extra) => listOfExtras.add(extra.mainOrExtra)));
      expect(listOfExtras, everyElement(isNot(MainOrExtra.main)));
    });

    test('Every main card should be in MainOrExtra.main or MainOrExtra.both category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      var listOfMains =
          dailyMeals.map((meal) => meal.mainFood.mainOrExtra).toList();
      expect(listOfMains, everyElement(anyOf([MainOrExtra.main, MainOrExtra.both])));
    });

    test('Every extra card should be in MainOrExtra.extra or MainOrExtra.both category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      var listOfExtras = [];
      dailyMeals.forEach((meal) =>
          meal.extras.forEach((extra) => listOfExtras.add(extra.mainOrExtra)));
      expect(listOfExtras, everyElement(anyOf([MainOrExtra.extra, MainOrExtra.both])));
    });

  });

  //INFO: Diabéticos tipo 1 nao devem jejuar na parte da manhã (Segundo mae)

  //Testar a montagem de cada refeição
  //Receber a refeição do dia e obrigar a ser 4 por dia
  group('Testing daily meals for people that dont do exercice: ', () {
    /* Refeições diarias para pessoas que não fazem exercícios:
    - A quantidade de refeições por dia deve ser 4
    - A ordem dos pratos principais atendem as respectivas categorias [drink, meat, meat, fruit]
    - Primeira refeição deve ser alguma bebida
    - Primeira refeição não deve ter acompanhamentos
    - Segunda refeição deve ser alguma proteina animal
    - Segunda refeição deve ser acompanhado de vegetais
    - Terceira refeição deve ser um prato de proteina mais leve, como ovos e derivados do leite(iogurte e queijo)
    - Terceira refeição não deve ter acompanhamento
    - Ultima refeição deve ser alguma proteina animal
    - Ultima refeição deve ser acompanhado de vegetais, frutas de baixo indice glicemigo e legumes
    */

    SharedPreferences.getInstance().then((prefs) async =>
        await prefs.setStringList(foodPrefsKey, mockedFoodPrefs));

    List<MealModel> dailyMeals = [];

    test('Total meals of the day should be 4', () async {
      dailyMeals = await repository.fetchDailyMeals();
      expect(dailyMeals.length, 4);
    });
    test(
        'The food category ordered by meal order should be drink, meat, eggs and meat',
        () async {
      dailyMeals = await repository.fetchDailyMeals();
      List<FoodCategory> foodCategoryOrderedByMeals = [];
      dailyMeals.forEach(
          (meal) => foodCategoryOrderedByMeals.add(meal.mainFood.category));
      expect(foodCategoryOrderedByMeals, [
        FoodCategory.drink,
        FoodCategory.meat,
        FoodCategory.eggs, //FIXME: Nao decidi ainda
        FoodCategory.meat,
      ]);
    });

    test('First meal of the day should be in drink category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      expect(dailyMeals.first.mainFood.category, FoodCategory.drink);
    });

    test('First meal of the day should not have extras', () async {
      dailyMeals = await repository.fetchDailyMeals();
      expect(dailyMeals.first.extras.length, 0);
    });

    test('Second meal of the day should be in meat category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      expect(dailyMeals[1].mainFood.category, FoodCategory.meat);
    });

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

    test('Third meal of the day should be in dairy or eggs category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      expect(dailyMeals[2].mainFood.category,
          anyOf([FoodCategory.dairy, FoodCategory.eggs]));
    });

    test('Third meal of the day should not have any extra', () async {
      dailyMeals = await repository.fetchDailyMeals();
      expect(dailyMeals[2].extras.length, 0);
    });

    test('Last meal of the day should be in fruit category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      expect(dailyMeals[3].mainFood.category, FoodCategory.meat);
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
      expect(extraCategoriesFromLastMeal, everyElement(FoodCategory.vegetable));
    });
  });

  group('Testing the build of the food of the entire week (Default pattern): ',
      () {
    /* Cardápios da semana baseado em refeições diarias com o mesmo padrão
    - Quantidade de cardápios diarios deve ser de 7(Sendo a quantidade de dias na semana)
    - Quantidade de refeições na semana deve ser de 28 caso tenha escolhido alguma fruta
    */
    SharedPreferences.getInstance().then((prefs) async =>
        await prefs.setStringList(foodPrefsKey, mockedFoodPrefs));

    List<List<MealModel>> dailyMenuOfTheWeek = [];
    test('Menu of the Week should have 7 elements', () async {
      dailyMenuOfTheWeek = await repository.fetchDailyMenuOfTheWeek();
      expect(dailyMenuOfTheWeek.length, 7);
    });

    test('Total amount of meals should be 28 by default', () async {
      dailyMenuOfTheWeek = await repository.fetchDailyMenuOfTheWeek();
      var meals = [];
      dailyMenuOfTheWeek
          .forEach((day) => day.forEach((meal) => meals.add(meal)));
      expect(meals.length, 28);
    });
  });
}

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
