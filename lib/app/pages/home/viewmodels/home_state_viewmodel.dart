import 'package:get/get.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/models/home_state_model.dart';


abstract class IHomeStateVM {
  Rx<HomeState> get homeState;
  set setHomeState(HomeState state);
  void onMenuNextState();
  void onOverViewNextState();
  Future<HomeState> fetchHomeState();
  changeStateWhithoutSave(HomeState state);
}


class HomeStateViewModel implements IHomeStateVM {
  //TODO: Passar para a home_controller algumas responsabilidades
  //TODO: Esse cara ainda ta feiao comparado aos outros, pois o controlador dele é o home controller puro
  final HomeStateModel _homeStateModel = HomeStateModel(); // Remover o Getx de dentro dele e tornar ele um Rx na home controller
  //TODO: passar esse model ^ para a home controller, pois 
  //nao quero correr o risco do estado alterar e a home model so chama na hora de criar a home page
  final ILocalStorage storage;

  HomeStateViewModel({
    required this.storage,
  });

  Rx<HomeState> get homeState => _homeStateModel.state;
  set setHomeState(HomeState state) => _homeStateModel.state.value = state;

  final String _homeStateKey =
      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day.toString()}/homeState';

  Future<HomeState> fetchHomeState() async {
    int val = (await storage.get(_homeStateKey)) ?? 1;
    return HomeState.values[val];
  }

  void onMenuNextState() {
    _changeState(HomeState.Review);
  }
  //TODO: Criar funcao chamada nextState que descobre qual o estado e define qual o proximo 

  void onOverViewNextState() {
    _changeState(HomeState.Menu);
  }

  _changeState(HomeState state) {
    _homeStateModel.state.value = state;
    storage.put(_homeStateKey, _homeStateModel.state.value!.index);
  }

  changeStateWhithoutSave(HomeState state) {
    _homeStateModel.state.value = state;
    // storage.put(homeStateKey, homeStateModel.state.value!.index);
  }
}
