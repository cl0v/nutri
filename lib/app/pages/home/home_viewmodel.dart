import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/home_model.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';

abstract class IHomeBloc {
  Future<List<HomeModel>> homeModelList(String day);
  Future saveHomeModel(String day, HomeModel homeModel);
}

//Posso ter a opção de enviar o dia por parametro(Repensar isso, evitando assim pedir o dia todas as vezes)

class HomeViewModel implements IHomeBloc {
  IDiet repository;
  ILocalStorage storage;
  HomeViewModel({
    required this.repository,
    required this.storage,
  });

  @override
  Future<List<HomeModel>> homeModelList(String day) async {
    List<HomeModel> list = await _requestHomeModelListFromStorage(day);
    if (list.length == 4)
      return _requestHomeModelListFromStorage(day);
    else
      return requestHomeModelListFromRepository(day);
  }

  Future<List<HomeModel>> _requestHomeModelListFromStorage(String day) async {
    List<HomeModel> list = <HomeModel>[];
    try {
      for (var type in MealType.values) {
        var json = await storage.get('$day/${type.toString()}');
        if (json != null) list.add(HomeModel.fromJson(json));
      }
    } catch (e) {}

    return list;
  }

  //TODO: Quando vejo outros dias, ele nao está recebendo do banco, apenas no primeiro dia

  Future<List<HomeModel>> requestHomeModelListFromRepository(String day) async {
    var list = await repository.fetchDietList();
    return list.map(
      (diet) {
        var homeModel = HomeModel(
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
        );
        storage.put(
          '$day/${homeModel.meal.type.toString()}',
          homeModel.toJson(),
        );
        return homeModel;
      },
    ).toList();
  }

  @override
  Future saveHomeModel(String day, HomeModel homeModel) async {
    storage.put('$day/${homeModel.meal.type.toString()}', homeModel.toJson());
  }
}
