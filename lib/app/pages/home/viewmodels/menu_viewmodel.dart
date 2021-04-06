import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:nutri/app/pages/home/models/menu_model.dart';
import 'package:nutri/app/repositories/pe_diet_repository.dart';

abstract class IMenuVM {
  Future<int> fetchMenuIndex();
  Future<void> setMenuIndex(int idx);
  Future<List<MenuModel>> fetchMenuList(String day);
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
      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}/$_menuIndexKey';

  Future<int> fetchMenuIndex() async {
    return await storage.get(menuIndexKey) ?? 0;
  }

  Future<void> setMenuIndex(idx) async {
    await storage.put(menuIndexKey, idx);
  }

//TODO: Encontrar item a item? Ou ja pegar os do dia todo?
  Future<List<MenuModel>> fetchMenuList(day) async {
    return [
      MenuModel.fromDietModel((await diet.breakfast(day))),
      MenuModel.fromDietModel((await diet.lunch(day))),
      MenuModel.fromDietModel((await diet.snack(day))),
      MenuModel.fromDietModel((await diet.dinner(day))),
    ];
  }
}
