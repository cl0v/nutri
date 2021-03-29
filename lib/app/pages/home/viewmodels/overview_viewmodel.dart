import 'package:get/get.dart';
import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/viewmodels/home_diet_viewmodel.dart';

class OverviewViewModel {
  OverviewViewModel({
    required this.homeDietViewModel,
  });

  final HomeDietViewModel homeDietViewModel;

  final overviewList = <MealModel>[].obs;

  init() async {
    overviewList.assignAll(
      await homeDietViewModel.getOverviewList(DateTime.now().weekday),
    );
  }

  changeOverview(int day) async {
    overviewList.assignAll(
      await homeDietViewModel.getOverviewList(day),
    );
  }
}
