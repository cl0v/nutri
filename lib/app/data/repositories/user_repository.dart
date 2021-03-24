import 'package:nutri/app/data/providers/user_provider.dart';

class UserRepository {
  final UserProvider provider;

  UserRepository({required this.provider});

  Stream<UserConnectionState> getUserConnectionState() =>
      provider.getUserConnectionState();
  closeUserConnectionState() => provider.closeUserConnectionState();
  String getUserLoginError() => provider.getUserLoginError();
  String getUserRegisterError() => provider.getUserRegisterError();

  signin(String email, String password) => provider.signin(email, password);

  register(String email, String password) => provider.register(email, password);
}
