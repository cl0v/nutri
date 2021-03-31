import 'package:nutri/app/interfaces/providers/diet_interface.dart';
import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';

class MenuViewModel {

  final IDiet diet;
  final ILocalStorage storage;

  MenuViewModel({
    required this.diet,
    required this.storage,
  });

  final String _menuIndexKey = 'menuIndex';
  String get menuIndexKey =>
      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day.toString()}/$_menuIndexKey';

  Future<int> fetchMenuPageIndex() async {
    return await storage.get(menuIndexKey) ?? 0;
  }

  Future<void> setMenuPageIndex(idx) async {
    await storage.put(menuIndexKey, idx);
  }

  Future<List<MenuModel>> fetchMenuList(int day) async {
    return [
      MenuModel.fromDietModel((await diet.getBreakfast(day))),
      MenuModel.fromDietModel((await diet.getLunch(day))),
      MenuModel.fromDietModel((await diet.getSnack(day))),
      MenuModel.fromDietModel((await diet.getDinner(day))),
    ];
  }
}
