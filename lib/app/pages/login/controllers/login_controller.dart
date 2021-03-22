import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/providers/user_provider.dart';
import 'package:nutri/app/data/repositories/user_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final UserRepository repository;
  LoginController({required this.repository});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool _loginError = false.obs;
  RxString _errorMsg = ''.obs;
  RxBool _isObscurePassword = true.obs;

  bool get loginError => _loginError.value!;
  String get errorMsg => _errorMsg.value!;
  bool get isObscurePassword => _isObscurePassword.value!;

  Rx<UserConnectionState> _userConnectionState = UserConnectionState.Idle.obs;

  @override
  void onInit() {
    super.onInit();
    ever(_userConnectionState, userConnectionStateChanged);
    _userConnectionState.bindStream(repository.getUserConnectionState());
  }
  

  userConnectionStateChanged(state) {
    switch (state) {
      case UserConnectionState.Error:
        _showLoginErrors(repository.getUserLoginError());
        break;
      case UserConnectionState.Connected:
        Get.offAllNamed(Routes.HOME);
        break;
    }
  }

  onCreateAccountPressed() {
    Get.toNamed(Routes.REGISTER);
  }

  // onForgetPasswordPressed() {
  //   //TODO: Implement onForgetPasswordPressed
  // }

  @override
  void onClose() {
    FocusScope.of(Get.context!).unfocus();
    repository.closeUserConnectionState();
    super.onClose();
  }

  onEnterPressed() async =>
      await repository.signin(emailController.text, passwordController.text);

  _showLoginErrors(msg) {
    _loginError.value = true;
    _errorMsg.value = msg;
  }

  onShowPasswordPressed() => _isObscurePassword.toggle();
}
