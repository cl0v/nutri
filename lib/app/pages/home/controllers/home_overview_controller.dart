import 'package:nutri/app/pages/home/models/home_meal_model.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/home/viewmodels/meal_card_viewmodel.dart';

class HomeOverviewController {
  late IMealCardVM mealCardViewModel;

  HomeOverviewController({
    required this.mealCardViewModel,
  });

  final _overviewList = <HomeMealModel>[].obs;

  List<HomeMealModel> get overViewList => _overviewList;

  bool isTodayOverview = true;

  init(String day) async {
    _overviewList.assignAll(
      await mealCardViewModel.fetchMealCardList(day),
    );
  }

  changeOverview(String day) async {
    _overviewList.assignAll(await mealCardViewModel.fetchMealCardList(day));
  }
}
