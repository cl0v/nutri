import 'package:nutri/app/interfaces/repositories/diet_interface.dart';
import 'package:nutri/app/pages/home/models/review_model.dart';
import 'package:nutri/app/pages/home/models/overview_model.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';

class PeDietRepository implements IDiet{
  @override
  Future<List<MenuModel>> getMenuList() {
    // TODO: implement getMenuList
    throw UnimplementedError();
  }

  @override
  Future<List<OverviewModel>> getOverviewList() {
    // TODO: implement getOverviewList
    throw UnimplementedError();
  }

  @override
  Future<List<ReviewModel>> getReviewList() {
    // TODO: implement getReviewList
    throw UnimplementedError();
  }
}