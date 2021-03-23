import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/models/home_state_model.dart';

class HomeStateViewModel {
  final HomeStateModel homeStateModel = HomeStateModel();
  final ILocalStorage storage;

  HomeStateViewModel({
    required this.storage,
  });

  final String _homeStateKey = 'homeState';
  String get homeStateKey =>
      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day.toString()}/$_homeStateKey';

  init() async {
    homeStateModel.state.value = await getTodayState();
  }

  Future<HomeState> getTodayState() async {
    int val = (await storage.get(homeStateKey)) ?? 1;
    return HomeState.values[val];
  }

  changeState(HomeState state) {
    homeStateModel.state.value = state;
    storage.put(homeStateKey, homeStateModel.state.value!.index);
  }
  changeStateWhithoutSave(HomeState state) {
    homeStateModel.state.value = state;
    // print(state);
    // storage.put(homeStateKey, homeStateModel.state.value!.index);
  }
}
