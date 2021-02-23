import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  PageController pageController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageController = PageController();
  }

  void onContinuePressed() {
    //TODO: Implement onContinuePressed
    pageController.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  _createAccount() async {
    //TODO:Implement Create Account
  }

  void onConfirmPressed(context) async {
    FocusScope.of(context).unfocus();
    await _createAccount();
    Get.offAllNamed(Routes.QUESTIONS);
  }
}
