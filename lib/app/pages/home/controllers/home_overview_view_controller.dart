import 'package:nutri/app/models/meal_model.dart';
import 'package:nutri/app/pages/home/viewmodels/overview_viewmodel.dart';

class HomeOverviewViewController{
  final OverviewViewModel overviewViewModel;

  HomeOverviewViewController({required this.overviewViewModel});
  List<MealModel> get overViewList => overviewViewModel.overviewList;

  bool isTodayOverview = true;
}