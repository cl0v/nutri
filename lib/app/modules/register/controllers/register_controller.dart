import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/repositories/user_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';
import 'package:nutri/constants.dart';

class RegisterController extends GetxController {
  final UserRepository repository;
  RegisterController({@required this.repository});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  PageController pageController;

  final _thermIsChecked = false.obs;

  bool get thermIsChecked => _thermIsChecked.value;

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

  checkTerms(bool val) {
    _thermIsChecked.value = val;
  }

  _createAccount() async {
    repository.register(emailController.text, passwordController.text);
  }

  void onConfirmPressed(context) async {
    if (!thermIsChecked)
      return Get.snackbar(
        'Confirme os termos',
        'Por favor confirme os termos antes de continuar.',
        backgroundColor: kRedColor,
        colorText: Colors.white,
      );
    FocusScope.of(context).unfocus();
    
    await _createAccount();
    Get.offAllNamed(Routes.QUESTIONS);
  }
}
