import 'package:nutri/app/interfaces/services/local_storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedLocalStorageService implements ILocalStorage {
  @override
  Future delete(String key) async {
    var shared = await SharedPreferences.getInstance();
    return shared.remove(key);
  }

  @override
  Future get(String key) async {
    var shared = await SharedPreferences.getInstance();
    return shared.get(key);
  }

  @override
  Future put(String key, dynamic value) async {
    var shared = await SharedPreferences.getInstance();
    //TODO: Testar e substituir para switch
    if (value is bool) {
      shared.setBool(key, value);
    }
    if (value is String) {
      shared.setString(key, value);
    }
    if (value is int) {
      shared.setInt(key, value);
    }
    if (value is List<String>) {
      shared.setStringList(key, value);
    }
  }
}
