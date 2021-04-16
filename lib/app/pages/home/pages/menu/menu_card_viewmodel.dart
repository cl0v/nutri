import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/pages/menu/menu_card_model.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';

abstract class IMenuCardBloc {
  Future<MenuCardModel> fetchMenuCardModel(MealModel meal);
  Future save(MenuCardModel menu);
}

class MenuCardViewModel implements IMenuCardBloc {
  final IDiet diet;

  MenuCardViewModel({
    required this.diet,
  });

  
  
  @override
  Future<MenuCardModel> fetchMenuCardModel(MealModel meal) async {
    var dietModel = await diet.fetchDietFromMeal(meal);
    return MenuCardModel(diet: dietModel);
  }

  requestMenuCard(String day, MealModel meal){
    //recebe o meal, verifica se ja existe o menu no banco de dados, caso nao,
    // cria um, e retorna o menucard
  }

  @override
  Future save(MenuCardModel menu) {
    // TODO: implement saveMenuCardModel
    throw UnimplementedError();
  }


}
