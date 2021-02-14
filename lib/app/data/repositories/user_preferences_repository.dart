import 'package:meta/meta.dart';
import 'package:nutri/app/data/providers/user_preferences_provider.dart';

class UserPreferencesRepository {
  final UserPreferencesProvider provider;

  UserPreferencesRepository({@required this.provider});

  void setUserInfo(Map<String, String> answers) => provider.setUserInfo(answers);
  Future<Map<String, String>> getUserInfo() => provider.getUserInfo();
}
