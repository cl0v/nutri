import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/interfaces/repositories/user_auth_inferface.dart';
import 'package:nutri/app/routes/app_pages.dart';
import 'package:nutri/app/viewmodels/user_auth_viewmodel.dart';

class LoginController extends GetxController {
  LoginController({
    required this.userAuthViewModel,
  });

  IUserAuthLoginBloc userAuthViewModel;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool _isObscurePassword = true.obs;
  bool get isObscurePassword => _isObscurePassword.value!;

  RxBool _loginError = false.obs;
  bool get loginError => _loginError.value!;
  RxString _errorMsg = ''.obs;
  String get errorMsg => _errorMsg.value!;

  @override
  void onInit() {
    super.onInit();
    ever(userAuthViewModel.loginState, onLoginStateChanged);
  }

  onLoginStateChanged(state) async {
    switch (state) {
      case LoginState.Connected:
        Get.offAllNamed(Routes.HOME);
        break;
      case LoginState.Error:
        _loginError.value = true;
        _errorMsg.value = await userAuthViewModel.errorMessage();
        break;
      default:
    }
  }

  onLoginPressed() async {
    //TODO: Conferir se os dados foram preenchidos corretamente
    return await userAuthViewModel.login(
        emailController.text, passwordController.text);
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
