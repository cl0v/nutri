import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/interfaces/repositories/user_auth_inferface.dart';
import 'package:nutri/app/routes/app_pages.dart';

class LoginController extends GetxController {
  LoginController({
    required this.userAuth,
  });

  IUserAuth userAuth;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool _isObscurePassword = true.obs;
  bool get isObscurePassword => _isObscurePassword.value!;

  Rx<LoginState> loginState = LoginState.Idle.obs;

  RxBool _loginError = false.obs;
  bool get loginError => _loginError.value!;
  RxString _errorMsg = ''.obs;
  String get errorMsg => _errorMsg.value!;

  @override
  void onInit() {
    super.onInit();
    ever(loginState, onLoginStateChanged);
  }

  @override
  void onReady() async {
    super.onReady();
  }

  onLoginStateChanged(state) async {
    switch (state) {
      case LoginState.Connected:
        Get.offAllNamed(Routes.HOME);
        break;
      case LoginState.Error:
        _loginError.value = true;
        _errorMsg.value = await userAuth.getErrorMessage();
        break;
      default:
    }
  }

  onLoginPressed() async {
    //TODO: Conferir se os dados foram preenchidos corretamente
    loginState.value = await userAuth.signIn(
      emailController.text,
      passwordController.text,
    );
  }

  onCreateAccountPressed() {
    Get.toNamed(Routes.REGISTER);
  }

  onForgetPasswordPressed() {
    //TODO: Implement onForgetPasswordPressed
  }

  @override
  void onClose() {
    FocusScope.of(Get.context!).unfocus();
    super.onClose();
  }

  onShowPasswordPressed() => _isObscurePassword.toggle();
}
