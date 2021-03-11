import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutri/app/data/repositories/user_repository.dart';
import 'package:nutri/app/routes/app_pages.dart';
import 'package:nutri/constants.dart';

class RegisterController extends GetxController {
  final UserRepository repository;
  RegisterController({required this.repository});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  PageController pageController = PageController(); 

  final RxBool _thermIsChecked = false.obs;
  final RxBool _isObscurePassword = true.obs;

  bool get thermIsChecked => _thermIsChecked.value!;
  bool get isObscurePassword => _isObscurePassword.value!;

  @override
  void onInit() {
    super.onInit();
  }

  void onContinuePressed() {
    //TODO: Implement onContinuePressed
    //TODO: Marcar como obrigatório os campos
    pageController.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  checkTerms(bool? val) =>
    _thermIsChecked.value = val;
  

  _createAccount() async => repository.register(emailController.text, passwordController.text);


  @override
  void onClose() {
    FocusScope.of(Get.context!).unfocus();
    super.onClose();
  }

  void onConfirmPressed(context) async {
    if (!thermIsChecked)
      return Get.snackbar(
        'Confirme os termos',
        'Por favor confirme os termos antes de continuar.',
        backgroundColor: kRedColor,
        colorText: Colors.white,
      );

    await _createAccount();
    Get.offAllNamed(Routes.QUESTIONS);
  }

  void onCancelRegisterPressed() {
    // TODO: Mostrar mensagem de aviso caso algo tenha sido preenchido
    // TODO: Implement onCancelRegisterPressed
    Get.back();
  }

  void onShowPasswordPressed() =>
    _isObscurePassword.toggle();
  
}
