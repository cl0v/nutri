import 'package:get/get.dart';
import 'package:nutri/app/interfaces/repositories/user_auth_inferface.dart';

abstract class IUserAuthConnectionStateBloc {
  Future<bool> isUserConnected();
}

abstract class IUserAuthLoginBloc {
  Rx<LoginState> get loginState;
  login(String email, String password);
  Future<String> errorMessage();
}

abstract class IUserAuthRegisterBloc {
  Rx<RegisterState> get registerState;
  register(String email, String password);
  Future<String> errorMessage();
}

class UserAuthViewModel
    implements
        IUserAuthConnectionStateBloc,
        IUserAuthLoginBloc,
        IUserAuthRegisterBloc {
  final IUserAuth auth;

  UserAuthViewModel({
    required this.auth,
  });

  Rx<LoginState> loginState = LoginState.Idle.obs;
  Rx<RegisterState> registerState = RegisterState.Idle.obs;

  Future<bool> isUserConnected() async {
    return await auth.isUserConnected();
  }

  login(String email, String password) async {
    loginState.value = await auth.signIn(email, password);
  }

  register(String email, String password) async {
    registerState.value = await auth.signUp(email, password);
  }

  Future<String> errorMessage() async => await auth.getErrorMessage();
}
