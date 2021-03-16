import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/providers/user_provider.dart';
import 'package:nutri/app/data/repositories/user_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final UserRepository repository;
  RegisterController({required this.repository});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  final RxBool _isObscurePassword = true.obs;

  bool get isObscurePassword => _isObscurePassword.value!;

  RxBool _registerError = false.obs;
  RxString _errorMsg = ''.obs;
  bool get registerError => _registerError.value!;
  String get errorMsg => _errorMsg.value!;
  Rx<UserConnectionState> _userConnectionState = UserConnectionState.Idle.obs;

  @override
  void onInit() {
    super.onInit();
    ever(_userConnectionState, userConnectionStateChanged);
    _userConnectionState.bindStream(repository.getUserConnectionState());
  }

  userConnectionStateChanged(state) {
    print(state);
    switch (state) {
      case UserConnectionState.Error:
        _showErrors(repository.getUserRegisterError());
        break;
      case UserConnectionState.Connected:
        Get.offAllNamed(Routes.QUESTIONS);

        break;
    }
  }

  _showErrors(msg) {
    _registerError.value = true;
    _errorMsg.value = msg;
  }

  @override
  void onClose() {
    FocusScope.of(Get.context!).unfocus();
    super.onClose();
  }

  void onConfirmPressed() async {
    if (emailController.text != '' && passwordController.text != '') {
      await repository.register(emailController.text, passwordController.text);
    }
  }

  void onShowPasswordPressed() => _isObscurePassword.toggle();
}
