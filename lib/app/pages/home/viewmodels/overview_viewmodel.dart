import 'package:get/get.dart';
import 'package:nutri/app/pages/home/models/overview_model.dart';
import 'package:nutri/app/pages/home/repositories/home_repository.dart';

class OverviewViewModel {
  final HomeRepository repository;

  OverviewViewModel({
    required this.repository,
  }); //TODO: Implement

  final overviewList = <OverviewModel>[].obs;

//TODO: Implement onInit
  init() async {
    overviewList.assignAll(
      await repository.getOverViewListFromPEDietSugestion(),
    );
  }

  changeOverview(int day) {
    //TODO: Implement changeOverview
  }
}
