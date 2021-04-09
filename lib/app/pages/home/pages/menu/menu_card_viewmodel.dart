import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/pages/menu/menu_card_model.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';

abstract class IMenuCardBloc {
  Future<MenuCardModel> fetchMenuCardModel(MealModel meal);
}

class MenuCardViewModel implements IMenuCardBloc {
  final IDiet diet;

  MenuCardViewModel({
    required this.diet,
  });
  @override
  Future<MenuCardModel> fetchMenuCardModel(MealModel meal) async {
    var dietModel = await diet.fetchDiet(meal);
    return MenuCardModel(diet: dietModel);
  }
}
