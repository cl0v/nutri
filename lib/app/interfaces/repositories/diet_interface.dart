import 'package:nutri/app/pages/home/models/menu_model.dart';
import 'package:nutri/app/pages/home/models/overview_model.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';

abstract class IDiet {
  Future<List<OverviewModel>> getOverviewList();
  Future<List<MenuModel>> getMenuList();
  Future<List<ReviewModel>> getReviewList();
}
