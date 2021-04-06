import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/meal_card_model.dart';
import 'package:get/get.dart';
import 'package:nutri/app/pages/home/viewmodels/meal_card_viewmodel.dart';

class HomeOverviewController {
  late IMealCardVM mealCardViewModel;

  HomeOverviewController({
    required this.mealCardViewModel,
  });

  final _overviewList = <MealCardModel>[].obs;

  List<MealCardModel> get overViewList => _overviewList;

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
