import 'package:nutri/app/pages/home/models/menu_model.dart';

abstract class IMenuVM {
  Future<int> fetchMenuIndex();
  Future<void> setMenuIndex(int idx);
  Future<List<MenuModel>> fetchMenuList(int day);
}
