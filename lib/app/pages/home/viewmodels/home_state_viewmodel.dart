import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/models/home_state_model.dart';

class HomeStateViewModel {
  final HomeStateModel _homeStateModel = HomeStateModel();
  final ILocalStorage storage;

  HomeStateViewModel({
    required this.storage,
  });

  get state => _homeStateModel.state;

  final String _homeStateKey =
      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day.toString()}/homeState';

  Future init() async {
    _homeStateModel.state.value = await getTodayState();
  }

  Future<HomeState> getTodayState() async {
    int val = (await storage.get(_homeStateKey)) ?? 1;
    return HomeState.values[val];
  }

  changeState(HomeState state) {
    _homeStateModel.state.value = state;
    storage.put(_homeStateKey, _homeStateModel.state.value!.index);
  }

  changeStateToReview() {
    changeState(HomeState.Review);
  }

  changeStateWhithoutSave(HomeState state) {
    _homeStateModel.state.value = state;
    // storage.put(homeStateKey, homeStateModel.state.value!.index);
  }
}
