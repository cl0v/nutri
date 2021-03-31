import 'package:get/get.dart';
import 'package:nutri/app/pages/home/models/home_state_model.dart';

abstract class IHomeStateVM {
  Rx<HomeState> get getHomeState;
  set setHomeState(HomeState state);
  void onMenuNextState();
  void onOverViewNextState();
  Future<HomeState> fetchHomeState();
  changeStateWhithoutSave(HomeState state);
}
