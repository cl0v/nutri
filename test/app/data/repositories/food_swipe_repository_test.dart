@Skip('Refatoração sendo feita')
import 'package:flutter_test/flutter_test.dart';
import 'package:nutri/app/data/model/food_model.dart';
import 'package:nutri/app/data/model/food_swipe_model.dart';
import 'package:nutri/app/data/providers/food_swipe_provider.dart';
import 'package:nutri/app/data/repositories/food_swipe_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  final prefs = SharedPreferences.getInstance();
  final provider = FoodSwipeProvider(
    prefs: prefs,
  );
  FoodSwipeRepository repository = FoodSwipeRepository(
    provider: provider,
  );

  group('Food Swipe prefs: ', () {
    test('FoodSwipe prefs', () async {
      repository.setFoodPreferences(mockedFoodPrefs);
      var xp = (await prefs).getStringList('foodPrefs');
      expect(xp, mockedFoodPrefs);
    });
  });

  group('Build food swipe: ', () {
    /* Testar a construição do build swipe com base nas recomendações
    - Vegetais tirar limitacoes min 7 variedades por semana
    - Tuberculos maximo 5 minimo 2
    - Fruta sem acucar maximo 9 minimo 7
    - Carnes max 7 minimo 3
    - Bebidas sem maximo minimo 1
    */

    List<FoodSwipeModel> foodSwipeList = [];
    test('Food swipe should have minimum of 7 vegetables', () async {
      foodSwipeList = await repository.loadFoodSwipeList();
      var swipe = foodSwipeList.firstWhere((foodSwipe) =>
          foodSwipe.category ==
          FoodSwipeModel.getCategory(FoodCategory.vegetable));
      expect(swipe.minimum, greaterThanOrEqualTo(7));
    });
    test('Tubers should have maximum of 5 and minimum of 2', () async {
      foodSwipeList = await repository.loadFoodSwipeList();
      var swipe = foodSwipeList.firstWhere((swipe) =>
          swipe.category == FoodSwipeModel.getCategory(FoodCategory.tuber));
      expect(swipe.minimum, equals(2));
      expect(swipe.maximum, equals(5));
    });

    test('Low sugar fruits should have maximum of 9 and minimum of 7',
        () async {
      foodSwipeList = await repository.loadFoodSwipeList();
      var swipe = foodSwipeList.firstWhere((swipe) =>
          swipe.category ==
          FoodSwipeModel.getCategory(FoodCategory.lowSugarFruits));
      expect(swipe.minimum, equals(7));
      expect(swipe.maximum, equals(9));
    });

    test('Meat should have maximum of 7 and minimum of 3', () async {
      foodSwipeList = await repository.loadFoodSwipeList();
      var swipe = foodSwipeList.firstWhere((swipe) =>
          swipe.category == FoodSwipeModel.getCategory(FoodCategory.meat));
      expect(swipe.minimum, equals(3));
      expect(swipe.maximum, equals(7));
    });

    test('Drinks should have minimum of 1', () async {
      foodSwipeList = await repository.loadFoodSwipeList();
      var swipe = foodSwipeList.firstWhere((swipe) =>
          swipe.category == FoodSwipeModel.getCategory(FoodCategory.drink));
      expect(swipe.minimum, equals(1));
    });
  }, skip: true);
}
