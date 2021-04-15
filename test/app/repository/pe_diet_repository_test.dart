import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/models/food_model.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/providers/food_provider.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';

main() {
// TODO: Atualizacao: as comidas principais serão variaçoes de uma meal
// Adicionar campo na meal de FoodModel, que recebe o id da proteina principal do prato

  //TODO: Essa é a parte mais importante da regra de negocios do app
  //Aqui que será feito o build das refeições, ou seja, junta o meal, com as opções
  TestWidgetsFlutterBinding.ensureInitialized();
  IDiet dietRepository = PeDietRepository(foodProvider: FoodProvider());

  group('fetchDietFromMeal |', () {
    group('Breakfast |', () {
      var meal = MealModel(
        type: MealType.breakfast,
        img: 'img',
        title: 'title',
      );
      var future = dietRepository.fetchDietFromMeal(meal);
      test('Meal type should be breakfast', () async {
        var diet = await future;
        expect(diet.meal.type, equals(MealType.breakfast));
      });

      test('FoodList lenght should be 3', () async {
        var diet = await future;
        expect(diet.mainFoodList.length, equals(3));
      });

      test('Extra lenght should be 0', () async {
        var diet = await future;
        expect(diet.extraFoodList.length, equals(0));
      });

      test('FoodList should be category drink', () async {
        var diet = await future;
        diet.mainFoodList.forEach((element) {
          expect(element.category, equals(FoodCategory.drink));
        });
      });
    });

    group('Lunch |', () {
      var meal = MealModel(
        type: MealType.lunch,
        img: 'img',
        title: 'title',
      );
      var future = dietRepository.fetchDietFromMeal(meal);

      test('Meal type should be lunch', () async {
        var diet = await future;
        expect(diet.meal.type, equals(MealType.lunch));
      });

      test('FoodList lenght should be 3', () async {
        var diet = await future;
        expect(diet.mainFoodList.length, equals(3));
      });

      test('Extra lenght should be greaterThanOrEqualTo 6', () async {
        var diet = await future;
        expect(diet.extraFoodList.length, greaterThanOrEqualTo(6));
      });

      test('FoodList should be category meat', () async {
        var diet = await future;
        diet.mainFoodList.forEach((element) {
          expect(element.category, equals(FoodCategory.meat));
        });
      });
    });

    group('Snack |', () {
      var meal = MealModel(
        type: MealType.snack,
        img: 'img',
        title: 'title',
      );
      var future = dietRepository.fetchDietFromMeal(meal);

      test('Meal type should be snack', () async {
        var diet = await future;
        expect(diet.meal.type, equals(MealType.snack));
      });

      test('FoodList lenght should be 0', () async {
        var diet = await future;
        expect(diet.mainFoodList.length, equals(0));
      });

      test('Extra lenght should be 0', () async {
        var diet = await future;
        expect(diet.extraFoodList.length, equals(0));
      });
    });

    group('Dinner |', () {
      var meal = MealModel(
        type: MealType.dinner,
        img: 'img',
        title: 'title',
      );
      var future = dietRepository.fetchDietFromMeal(meal);

      test('Meal type should be dinner', () async {
        var diet = await future;
        expect(diet.meal.type, equals(MealType.dinner));
      });

      test('FoodList lenght should be 3', () async {
        var diet = await future;
        expect(diet.mainFoodList.length, equals(3));
      });

      test('Extra lenght should be greaterThanOrEqualTo 6', () async {
        var diet = await future;
        expect(diet.extraFoodList.length, greaterThanOrEqualTo(6));
      });
    });
  });
}
