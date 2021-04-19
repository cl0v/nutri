import 'package:nutri/app/pages/home/home_model.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';

abstract class IHomeBloc {
  Future<List<HomeModel>> homeModelList();
  Future saveHomeModel(String day);
}

//Posso ter a opção de enviar o dia por parametro(Repensar isso, evitando assim pedir o dia todas as vezes)

class HomeViewModel implements IHomeBloc {
  IDiet repository;
  
  HomeViewModel({
    required this.repository,
  });

  @override
  Future<List<HomeModel>> homeModelList() async {
    //TODO: Obviamente, ainda nao estou recebendo do banco de dados
    var list = await repository.fetchMealList();
    return list
        .map(
          (diet) => HomeModel(
            meal: diet.meal,
            status: Status.None,
            options: FoodOptionsModel(
              meals: diet.mainFoodList,
              extras: diet.extraFoodList,
            ),
            selected: SelectedFoodsModel(
              mealIdx: 0,
              extraIdxList: [],
            ),
          ),
        )
        .toList();
  }

  @override
  Future saveHomeModel(String day) {
    // TODO: implement saveHomeModel
    throw UnimplementedError();
  }
}
