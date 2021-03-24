import 'package:nutri/app/pages/home/models/menu_model.dart';
import 'package:nutri/app/pages/home/models/meal_model.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';

abstract class IDiet {
  Future<List<MealModel>> getOverviewList(int day);
  Future<List<MenuModel>> getMenuList();
  Future<List<ReviewModel>> getReviewList();
  Future setReview(MealModel overviewModel, bool done);
}
