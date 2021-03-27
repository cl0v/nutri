import 'package:nutri/app/models/user_auth_model.dart';

abstract class IUserAuth {
  Future<LoginState> signIn(String email, String password);
  Future<String> getErrorMessage();
  Future<RegisterState> signUp(String email, String password);
  Future<bool> isUserConnected();
  Future signOut();
}
