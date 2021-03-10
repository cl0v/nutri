import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/repositories/user_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final UserRepository repository;
  LoginController({@required this.repository});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool _loginError = false.obs;
  RxString _errorMsg = ''.obs;
  RxBool _isObscurePassword = true.obs;

  bool get loginError => _loginError.value;
  String get errorMsg => _errorMsg.value;
  bool get isObscurePassword => _isObscurePassword.value;

  onCreateAccountPressed() {
    Get.toNamed(Routes.REGISTER);
  }

  onForgetPasswordPressed() {
    //TODO: Implement onForgetPasswordPressed
  }

  @override
  void onClose() {
    FocusScope.of(Get.context).unfocus();
    super.onClose();
  }

  onEnterPressed() async {
    var response =
        await repository.signin(emailController.text, passwordController.text);
    // FocusScope.of(Get.context).unfocus();
    if (response)
      //TODO: Receber as infos pra saber do fluxo do app, pra onde enviar o cliente, question, swipe ou home
      Get.offAllNamed(Routes.HOME);
    else {
      //TODO: Implement mensagem de erro
      // String msg = await repository.getError();
      _showLoginErrors('Error ao efetuar login');
    }
  }

  _showLoginErrors(msg) {
    _loginError.value = true;
    _errorMsg.value = msg;
  }

  onShowPasswordPressed() => _isObscurePassword.toggle();
}
