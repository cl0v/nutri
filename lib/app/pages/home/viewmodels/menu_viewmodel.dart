import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';


abstract class IMenuVM {
  Future<int> fetchMenuIndex();
  Future<void> setMenuIndex(int idx);
  Future<List<MenuModel>> fetchMenuList(int day);
}


class MenuViewModel extends IMenuVM {
  final IDiet diet;
  final ILocalStorage storage;

  MenuViewModel({
    required this.diet,
    required this.storage,
  });

  final String _menuIndexKey = 'menuIndex';
  //TODO: Testar se da pra fazer sem o get
  String get menuIndexKey =>
      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day.toString()}/$_menuIndexKey';

  Future<int> fetchMenuIndex() async {
    return await storage.get(menuIndexKey) ?? 0;
  }

  Future<void> setMenuIndex(idx) async {
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
