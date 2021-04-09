import 'package:nutri/app/pages/home/models/home_card_model.dart';
import 'package:nutri/app/providers/meal_provider.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';

abstract class IMealCardBloc {
  Future<List<MealCardModel>> fetchHomeCardList(String day);
  Future saveHomeCard(String day, MealCardModel homeCard); //Review
}

class MealCardViewModel implements IMealCardBloc {
  final IMealProvider mealProvider;

  MealCardViewModel({required this.mealProvider});

  @override
  Future<List<MealCardModel>> fetchHomeCardList(String day) async {
    //TODO: Implement home
    //Esse cara vai producrar no banco de dados quais ja tem, os que tiver ele completa com os que ainda nao tem

    //Recebe os meals do banco de dados
    //_fetchMealsFromDB(){}
    //Envia para o

    return (await mealProvider.fetchMealList(day))
        .map((mealModel) => MealCardModel.fromMealModel(mealModel))
        .toList();
  }

  // Future<List<MealModel>> _fetchMealsFromDB(){}

  @override
  Future saveHomeCard(String day, MealCardModel homeCard) async {}
}
