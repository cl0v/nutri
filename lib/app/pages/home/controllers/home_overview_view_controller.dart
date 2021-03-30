import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/viewmodels/overview_viewmodel.dart';

class HomeOverviewViewController {
  late OverviewViewModel overviewViewModel;

  HomeOverviewViewController({
    required this.overviewViewModel,
  });


  init() => overviewViewModel.init();

  changeOverview(day) => overviewViewModel.changeOverview(day);

  List<MealModel> get overViewList => overviewViewModel.overviewList;

  bool isTodayOverview = true;
}
