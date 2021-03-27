import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/models/user_auth_model.dart';
import 'package:nutri/app/routes/app_pages.dart';
import 'package:nutri/app/viewmodels/user_auth_viewmodel.dart';

class RegisterController extends GetxController {
  RegisterController({
    required this.userAuthViewModel,
  });
  UserAuthViewModel userAuthViewModel;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  final RxBool _isObscurePassword = true.obs;
  bool get isObscurePassword => _isObscurePassword.value!;

  RxBool _registerError = false.obs;
  bool get registerError => _registerError.value!;
  RxString _errorMsg = ''.obs;
  String get errorMsg => _errorMsg.value!;

  @override
  void onInit() {
    super.onInit();
    ever(userAuthViewModel.model.registerState, userUserRegisterStateChanged);
  }

  userUserRegisterStateChanged(state) async {
    switch (state) {
      case RegisterState.Created:
        Get.offAllNamed(Routes.HOME);
        break;
      case RegisterState.Error:
        _registerError.value = true;
        _errorMsg.value = await userAuthViewModel.getError();
        break;
      default:
    }
  }

  @override
  void onClose() {
    FocusScope.of(Get.context!).unfocus();
    super.onClose();
  }

  void onConfirmPressed() async {
    if (emailController.text != '' && passwordController.text != '') {
      await userAuthViewModel.register(
          emailController.text, passwordController.text);
    }
  }

  void onShowPasswordPressed() => _isObscurePassword.toggle();
}
