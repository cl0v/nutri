import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/repositories/user_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final UserRepository repository;
  LoginController({@required this.repository});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onCreateAccountPressed() {
    Get.toNamed(Routes.REGISTER);
  }

  void onForgetPasswordPressed() {
    //TODO: Implement onForgetPasswordPressed
  }

  Future<void> onEnterPressed() async {
    var response =
        await repository.signin(emailController.text, passwordController.text);
    FocusScope.of(Get.context).unfocus();
    if (response)
      Get.offAllNamed(Routes.QUESTIONS);

    // Get.offAllNamed(Routes.HOME);
    else
      return;
  }
}
