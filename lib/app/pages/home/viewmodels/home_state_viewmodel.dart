import 'package:get/get.dart';
import 'package:nutri/app/interfaces/pages/home/viewmodels/home_state_viewmodel_interface.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/models/home_state_model.dart';

class HomeStateViewModel implements IHomeStateVM {
  //TODO: Passar para a home_controller algumas responsabilidades
  //TODO: Esse cara ainda ta feiao comparado aos outros, pois o controlador dele é o home controller puro
  final HomeStateModel _homeStateModel = HomeStateModel();
  final ILocalStorage storage;

  HomeStateViewModel({
    required this.storage,
  });

  Rx<HomeState> get getHomeState => _homeStateModel.state;
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
