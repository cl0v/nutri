import 'package:get/get.dart';
import 'package:nutri/app/interfaces/repositories/diet_interface.dart';
import 'package:nutri/app/pages/home/models/meal_model.dart';

class OverviewViewModel {
  OverviewViewModel({
    required this.repository,
  });

  final IDiet repository;

  final overviewList = <MealModel>[].obs;

  init() async {
    overviewList.assignAll(
      await repository.getOverviewList(DateTime.now().weekday),
    );
  }

  changeOverview(int day) async {
    overviewList.assignAll(
      await repository.getOverviewList(day),
    );
  }
}
