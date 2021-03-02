import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/meal_model.dart';
import 'package:nutri/app/data/providers/meal_provider.dart';
import 'package:nutri/app/data/repositories/meal_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO: Testar a nao repetição dos extras quando tiver mais de um extra

final mockedFoodPrefs = [
  'Peito de Frango',
  'Picanha',
  'Salmão',
  'Brócolis',
  'Alface',
  'Espinafre',
  'Repolho Roxo',
  'Tomate',
  "Cenoura",
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

  group('Testing basic build of cards on the daily meals: ', () {
    /* Testar funcionalidade da FoodModel definindo se deve ser(na home) um card principal ou um card de extras
     - Nenhum card principal deve estar na categoria MainOrExtra.extra
     - Nenhum card de extra deve estar na categoria MainOrExtra.main
     - Todos os card principais devem estar na categoria MainOrExtra.main ou MainOrExtra.both
     - Todos os card de extra devem estar na categoria MainOrExtra.extra ou MainOrExtra.both
     - Nenhum extra deve repetir na mesma refeição
    */

    SharedPreferences.getInstance().then((prefs) async =>
        await prefs.setStringList(foodPrefsKey, mockedFoodPrefs));

    List<MealModel> dailyMeals = [];
    test('No main card should be in MainOrExtra.extra category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      var listOfMains = [];
      dailyMeals.forEach((meal) => listOfMains
          .addAll(meal.mainFoodList.map((food) => food.mainOrExtra)));
      expect(
        listOfMains,
        everyElement(isNot(MainOrExtra.extra)),
      );
    });

    test('No extra card should be in MainOrExtra.main category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      var listOfExtras = [];
      dailyMeals.forEach((meal) => listOfExtras
          .addAll(meal.extraList.map((extra) => extra.mainOrExtra)));
      expect(
        listOfExtras,
        everyElement(isNot(MainOrExtra.main)),
      );
    });

    test(
        'Every main card should be in MainOrExtra.main or MainOrExtra.both category',
        () async {
      dailyMeals = await repository.fetchDailyMeals();
      var listOfMains = [];
      dailyMeals.forEach((meal) => listOfMains
          .addAll(meal.mainFoodList.map((food) => food.mainOrExtra)));
      expect(
        listOfMains,
        everyElement(anyOf([MainOrExtra.main, MainOrExtra.both])),
      );
    });

    test(
        'Every extra card should be in MainOrExtra.extra or MainOrExtra.both category',
        () async {
      dailyMeals = await repository.fetchDailyMeals();
      var listOfExtras = [];
      dailyMeals.forEach((meal) => listOfExtras
          .addAll(meal.extraList.map((extra) => extra.mainOrExtra)));
      expect(
        listOfExtras,
        everyElement(anyOf([MainOrExtra.extra, MainOrExtra.both])),
      );
    });

    test('No extra should be repeat at the same meal', () async {
      dailyMeals = await repository.fetchDailyMeals();
      dailyMeals.forEach((meal) {
        var existingExtrasTitle = [];
        meal.extraList.forEach((extra) {
          expect(extra.title, isNot(anyOf(existingExtrasTitle)));
          existingExtrasTitle.add(extra.title);
        });
      });
    });
  });

  //INFO: Diabéticos tipo 1 nao devem jejuar na parte da manhã (Segundo mae)
  //TODO: Quando a pessoa marcar diabetes tipo 1, não liberar o app para ela, avisar que só estará disponivel numa proxima versão

  group('Testing daily meals for people that dont do exercice: (DEFAULT DIET) ',
      () {
    /* Refeições diarias para pessoas que não fazem exercícios:
    - A quantidade de refeições por dia deve ser 4
    - A ordem das comidas deve ser Breakfast, Lunch, Snack, Dinner
    - A ordem dos pratos principais atendem as respectivas categorias [drink, meat, snack, meat]
    - Primeira refeição deve ser alguma bebida
    - Primeira refeição não deve ter acompanhamentos
    - Segunda refeição deve ser alguma proteina animal
    - Segunda refeição deve ter 3 opções de proteina
    - Segunda refeição deve ser acompanhado de vegetais
    - Terceira refeição deve ser um prato de proteina mais leve, como ovos e derivados do leite(iogurte e queijo)
    - Terceira refeição não deve ter acompanhamento //IDEIA: (talvez para o iogurte(Adicionar alguma fruta que combine(morango etc)))
    - Ultima refeição deve ser alguma proteina animal
    - Ultima refeição deve ser acompanhado de vegetais, legumes e frutas de baixo indice glicemigo
    - Ultima refeição do dia deve sugerir pelo menos uma fruta de baixo indice glicemico
    - Ultima refeição do dia deve sugerir pelo menos um legume //TODO: Implement
    */

    SharedPreferences.getInstance().then((prefs) async =>
        await prefs.setStringList(foodPrefsKey, mockedFoodPrefs));

    List<MealModel> dailyMeals = [];

    test('Total meals of the day should be 4', () async {
      dailyMeals = await repository.fetchDailyMeals();
      expect(
        dailyMeals.length,
        4,
      );
    });

    test(
        'The order of the meals on the day should be breakfast, lunch, snack and dinner',
        () async {
      dailyMeals = await repository.fetchDailyMeals();

      expect(dailyMeals.map((meal) => meal.mealType).toList(), [
        MealType.breakfast,
        MealType.lunch,
        MealType.snack,
        MealType.dinner
      ]);
    });

    test(
        'The main food category ordered by meal order should be drink, meat, snack and meat',
        () async {
      dailyMeals = await repository.fetchDailyMeals();
      var foodCategoryOrderedByMeals = [];
      dailyMeals.forEach((meal) => foodCategoryOrderedByMeals
          .add(meal.mainFoodList.map((f) => f.category).toList()));
      expect(
        foodCategoryOrderedByMeals,
        [
          everyElement(FoodCategory.drink),
          everyElement(FoodCategory.meat),
          everyElement(anyOf(FoodCategory.eggs, FoodCategory.dairy)),
          everyElement(FoodCategory.meat),
        ],
      );
    });

    test('The main food of the breakfast should be in drink category',
        () async {
      dailyMeals = await repository.fetchDailyMeals();
      var mainFoodOfTheBreakfast = [];
      dailyMeals
          .firstWhere((meal) => meal.mealType == MealType.breakfast)
          .mainFoodList
          .forEach((food) => mainFoodOfTheBreakfast.add(food.category));
      expect(
        mainFoodOfTheBreakfast,
        everyElement(FoodCategory.drink),
      );
    });

    test('Breakfast should not have extras', () async {
      dailyMeals = await repository.fetchDailyMeals();

      expect(
        dailyMeals
            .firstWhere((meal) => meal.mealType == MealType.breakfast)
            .extraList
            .length,
        0,
      );
    });

    test('The main food of the lunch should be in meat category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      var mainFoodOfTheLunch = [];
      dailyMeals
          .firstWhere((meal) => meal.mealType == MealType.lunch)
          .mainFoodList
          .forEach((food) => mainFoodOfTheLunch.add(food.category));
      expect(
        mainFoodOfTheLunch,
        everyElement(FoodCategory.meat),
      );
    });

    test(
        'Lunch should have only extras in vegetables category, and at least 4 extras',
        () async {
      dailyMeals = await repository.fetchDailyMeals();
      List<FoodCategory> extraCategoriesFromLunch = [];
      dailyMeals
          .firstWhere((meal) => meal.mealType == MealType.lunch)
          .extraList
          .forEach(
            (extra) => extraCategoriesFromLunch.add(
              extra.category,
            ),
          );

      expect(
        extraCategoriesFromLunch.length,
        greaterThanOrEqualTo(4),
      );
      expect(
        extraCategoriesFromLunch,
        everyElement(FoodCategory.vegetable),
      );
    });

    test('The main food of the snack should be in dairy or eggs category',
        () async {
      dailyMeals = await repository.fetchDailyMeals();
      var mainFoodOfTheSnack = [];
      dailyMeals
          .firstWhere((meal) => meal.mealType == MealType.snack)
          .mainFoodList
          .forEach((food) => mainFoodOfTheSnack.add(food.category));
      expect(
        mainFoodOfTheSnack,
        everyElement(anyOf([FoodCategory.dairy, FoodCategory.eggs])),
      );
    });

    test('Snack should not have any extra', () async {
      dailyMeals = await repository.fetchDailyMeals();
      expect(
        dailyMeals
            .firstWhere((meal) => meal.mealType == MealType.snack)
            .extraList
            .length,
        0,
      );
    });

    test('The main food of the dinner should be in meat category', () async {
      dailyMeals = await repository.fetchDailyMeals();
      var mainFoodFromDinner = [];
      dailyMeals
          .firstWhere((meal) => meal.mealType == MealType.dinner)
          .mainFoodList
          .forEach((food) => mainFoodFromDinner.add(food.category));
      expect(
        mainFoodFromDinner,
        everyElement(FoodCategory.meat),
      );
    });

    test('Dinner should be neither vegetables, tubers or low sugar fruits',
        () async {
      dailyMeals = await repository.fetchDailyMeals();
      List<FoodCategory> extraCategoriesFromDinner = [];

      dailyMeals
          .firstWhere((meal) => meal.mealType == MealType.dinner)
          .extraList
          .forEach(
            (extra) => extraCategoriesFromDinner.add(
              extra.category,
            ),
          );
      expect(
        extraCategoriesFromDinner.length,
        greaterThanOrEqualTo(4),
      );
      expect(
        extraCategoriesFromDinner,
        everyElement(anyOf([
          FoodCategory.vegetable,
          FoodCategory.lowSugarFruits,
          FoodCategory.tuber,
        ])),
      );
    });
        test('Dinner should suggest at least one low sugar fruit', () async {
      dailyMeals = await repository.fetchDailyMeals();
      var extraCategoriesFromDinner = dailyMeals
          .lastWhere((meal) => meal.mealType == MealType.dinner)
          .extraList
          .map((extra) => extra.category).toList();
      expect(extraCategoriesFromDinner, anyElement(FoodCategory.lowSugarFruits));
    });
    test('Dinner should suggest at least one low sugar fruit', () async {
      dailyMeals = await repository.fetchDailyMeals();
      var extraCategoriesFromDinner = dailyMeals
          .lastWhere((meal) => meal.mealType == MealType.dinner)
          .extraList
          .map((extra) => extra.category).toList();
      expect(extraCategoriesFromDinner, anyElement(FoodCategory.lowSugarFruits));
    });
  });

  group('Testing the build of the food of the entire week (DEFAULT DIET): ',
      () {
    /* Cardápios da semana baseado em refeições diarias com o mesmo padrão
    - Quantidade de cardápios diarios deve ser de 7(Sendo a quantidade de dias na semana)
    - Quantidade de refeições na semana deve ser 28
    */
    SharedPreferences.getInstance().then((prefs) async =>
        await prefs.setStringList(foodPrefsKey, mockedFoodPrefs));

    List<List<MealModel>> dailyMenuOfTheWeek = [];
    test('Menu of the Week should have 7 elements', () async {
      dailyMenuOfTheWeek = await repository.fetchDailyMenuOfTheWeek();
      expect(
        dailyMenuOfTheWeek.length,
        7,
      );
    });

    test('Total amount of meals should be 28 by default', () async {
      dailyMenuOfTheWeek = await repository.fetchDailyMenuOfTheWeek();
      var meals = [];
      dailyMenuOfTheWeek
          .forEach((day) => meals.addAll(day.map((meal) => meal)));
      expect(
        meals.length,
        28,
      );
    });
  });
}

//TODO: Testar a quantidade de extras que pode ser selecionado cada dia

// Pratos Principais: Lanche(proteina mais leve), Almoço e Jantar(proteinas mais pesadas), Bebidas(nao caloricas)
// Acompanhamentos: Sempre será vegetais, tuberculos e frutas de baixo indice glicemico, além de ovos
// IDEIA: Perguntar se a pessoa tem alergia a albumina, então não recomendar ovos para essa pessoa
// Acompanhamentos não deverá possuir Carnes nem bebidas

//IDEIA: É importante saber qual o objetivo da pessoa(Emagrecimento, etc)
// - Deixar as pessoas que querem engordar e manter peso por ultimo no calculo do app
// Para pessoas que praticam atividade física moderada ou de alta intensidade, é importante saber o horario dos exercicios.
// Para pessoas que praticam atividade fisica de manha, a atividade deverá ser feita em jejum
// Para pessoas que não praticam atividade fisica, é indiferente
// Para pessoas que praticam alto nivel de intensidade fisica, recomendar frutas antes da atividade(não importante)

/*
Serão 4 refeiçoes por dia contando o cafe na parte da manha.
- Sendo a primeira refeiçao obrigatório alguma bebida sem calorias
- Sendo o almoço, a refeição principal com base em proteína animal, mais acompanhamentos
- Sendo a terceira refeição do dia, uma refeição leve com base em proteina, mais acompanhamentos
- Sendo uma refeiçao com base em proteína animal, mais acompanhamentos
*/

//.Exemplo padrao de combinaçao pode ser encontrado no livro
//1
/* Reforçando que essa pessoa não pratica exercicios fisicos, acorda as 7 e dorme as 11
  - Cafe da manha: Café preto, sem acompanhamento
  - Almoço: Peito de frango, acompanhado de vegetais
  - Lanche: Ovos, Queijos, Iogurte...
  - Jantar: Carne cozida, acompanhado de vegetais, legumes e frutas de baixo indice glicemico
*/

//2
/* Uma pessoa que pratica atividade fisica, acorda as 7 e dorme as 11 (Musculaçao)
// Preciso saber por volta de que horas ela malha, antes de malhar recomendar frutas, o quanto ela quiser
  - Cafe da manha: Café preto, sem acompanhamento
  - Almoço: Peito de frango, acompanhado de vegetais
  - Lanche: Ovos, Queijos, Iogurte...
  - Antes de malhar, Frutas, limitar a somente uma ou duas(variedades) de frutas por dia
  - Entre 9 e 11 da noite, Carne, acompanhado de vegetais
*/

//IDEIA: Lembrar do objetivo emagrecer e o quanto ela está disposta a 'sofrer',
// Para emagrecimento severo, duas refeições com base em proteina(Almoço e lanche) incluso café
// Por enquanto vou trabalhar com uma medida padrão que funcionaria para qualquer pessoa(Default)
