import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/meal_card_model.dart';
import 'package:nutri/app/pages/home/viewmodels/meal_card_viewmodel.dart';
import 'package:get/get.dart';

class HomeOverviewController {
  //DONE
  late MealCardViewModel mealCardViewModel;

  HomeOverviewController({
    required this.mealCardViewModel,
  });

  final _overviewList = <MealCardModel>[].obs;

  List<MealModel> get overViewList => _overviewList;

  bool isTodayOverview = true;

  init() async {
    _overviewList.assignAll(
      await mealCardViewModel.fetchMealCardList(
        DateTime.now().weekday,
      ),
    );
  }

  changeOverview(int day) async {
    _overviewList.assignAll(await mealCardViewModel.fetchMealCardList(day));
  }
}
