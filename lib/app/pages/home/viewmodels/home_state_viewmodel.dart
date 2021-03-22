import 'package:nutri/app/pages/home/models/home_state_model.dart';

class HomeStateViewModel {
  final HomeStateModel homeStateModel = HomeStateModel();

  init() {
    //TODO: Implement init
    homeStateModel.state.value = HomeState.Overview;
  }

  changeState(HomeState state) {
    homeStateModel.state.value = state;
  }
}
