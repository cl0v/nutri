import 'package:nutri/app/interfaces/repositories/user_auth_inferface.dart';
import 'package:nutri/app/models/user_auth_model.dart';

class UserAuthViewModel {
  final IUserAuth auth;

  UserAuthViewModel({
    required this.auth,
  });

  UserLoginModel model = UserLoginModel();

  Future<bool> isUserConnected() async {
    return await auth.isUserConnected();
  }

  login(String email, String password) async {
    model.loginState.value = await auth.signIn(email, password);
  }

  register(String email, String password) async {
    model.registerState.value = await auth.signUp(email, password);
  }

  Future<String> getError() async =>
      model.errorMessage.value = await auth.getErrorMessage();
}
