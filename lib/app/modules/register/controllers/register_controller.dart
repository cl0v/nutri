import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/routes/app_pages.dart';

class RegisterController extends GetxController {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onContinuePressed() {
    //TODO: Implement onContinuePressed
    Get.offAllNamed(Routes.QUESTIONS);
  }
}
