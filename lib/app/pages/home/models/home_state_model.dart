import 'package:get/get.dart';

enum HomeState {
  Loading,
  Overview,
  Menu,
  Review,
}

class HomeStateModel {
  Rx<HomeState> state = HomeState.Loading.obs;
}
