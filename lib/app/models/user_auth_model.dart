import 'package:get/state_manager.dart';

enum LoginState { Idle, Connected, Error }
enum RegisterState { Idle, Created, Error }

class UserLoginModel {
  Rx<LoginState> loginState = LoginState.Idle.obs;
  Rx<RegisterState> registerState = RegisterState.Idle.obs;
  RxString errorMessage = ''.obs;
}
