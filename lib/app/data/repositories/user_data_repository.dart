import 'package:meta/meta.dart';
import 'package:nutri/app/data/providers/user_data_provider.dart';

class UserDataRepository {
  final UserDataProvider provider;

  UserDataRepository({@required this.provider});

  void setUserInfo(Map<String, String> answers) => provider.setUserInfo(answers);
  Future<Map<String, String>> getUserInfo() => provider.getUserInfo();
}
