import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/routes/app_pages.dart';

class LoginController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onCreateAccountPressed() {
    Get.toNamed(Routes.REGISTER);
  }

  void onForgetPasswordPressed() {
    //TODO: Implement forget password btn
  }

  void onEnterPressed() {
    //TODO: Implement enter btn
    Get.offAllNamed(Routes.HOME);
  }
}
